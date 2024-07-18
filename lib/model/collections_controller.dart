import 'dart:convert';
import 'dart:ffi';
import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/util/translation_extension.dart';
import 'package:flutter/material.dart'; 
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
 
class FilbisDatabase extends ChangeNotifier {
  static late Isar isar;

  // Variables for module display
  String? currQuestion = "Filbis is thinking...";
  late Module? currModule; 
  late SubModule? currSub;
  late String? subModule;
  late List<String>? currAnswers = []; 
  late MedicalRecord currRecord = MedicalRecord();
  late String currChildID = "";
  late String currLanguage;

  List<MedicalRecord> storedRecords = [];

  // Initializes IsarDB
  static Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ModuleSchema, ChildrenHealthDataSchema],
      directory: dir.path 
    );
  }

  // Initialize the data from web server to the isar database
  static initDb() async {
    try {
      var url = Uri.http('10.0.2.2:8000', '/mobile_download_modules');
      http.post(url, body: {}).then((response) async {
        var data = json.decode(response.body);
        // for each module in the data, add it to the database
        for (var key in data.keys) {
          final mod = Module()..name = key;
          await isar.writeTxn(() async {
            await isar.modules.put(mod);
          });
          final subModules = data[key];
          for (var subKey in subModules.keys){
            if (key != 'mobile_routes') {
              // for each submodule, set the qckreply and stuff
              final subMod = SubModule()..name = subKey;
              final qckReply = QckReply();
              final questionTranslation = QuestionTranslation();
              final mobile = Mobile();

              // set the qckReply
              if (subModules[subKey]["qck_reply"] != null){
                qckReply.englishReplies = subModules[subKey]["qck_reply"]["english_replies"].cast<String>();
                qckReply.cebuanoReplies = subModules[subKey]["qck_reply"]["cebuano_replies"].cast<String>();
                qckReply.tagalogReplies = subModules[subKey]["qck_reply"]["tagalog_replies"].cast<String>();
              }
              // set the questionTranslation
              if (subModules[subKey]["question_translation"] != null){
                questionTranslation.englishResponse = subModules[subKey]["question_translation"]["english_response"];
                questionTranslation.cebuanoResponse = subModules[subKey]["question_translation"]["cebuano_response"];
                questionTranslation.tagalogResponse = subModules[subKey]["question_translation"]["tagalog_response"];
              }
              // set the Mobile
              if (subModules[subKey]["mobile"] != null){
                mobile.dataKey = subModules[subKey]["mobile"]["data_key"] ?? "";
                mobile.yesNext = subModules[subKey]["mobile"]["yes_next"] ?? "";
                mobile.next = subModules[subKey]["mobile"]["next"] ?? "END";
              }
              // set the subModule
              subMod.qckReply = qckReply;
              subMod.questionTranslation = questionTranslation;
              subMod.mobile = mobile;
              // add the subModule to the module's embedded list
              await isar.writeTxn(() async {
                await isar.modules.put(mod..subModule.add(subMod));
              });
            }
          }
        }

        // iterate through modules again
        for (var key in data.keys) {
          // look at mobile_routes module only
          if (key == 'mobile_routes') {
          final subModules = data[key];
            // for each 'submodule' in mobile_routes
            for (var subKey in subModules.keys) {
              // loop through the current submodule's order list and add each item to matching module's order list
              for (var order in subModules[subKey]["order"]) {
                await isar.writeTxn(() async {
                  // get the module whose name matches the current mobile_routes submodule
                  final module = await isar.modules.filter().nameEqualTo(subKey).findFirst();
                  module!.order = List.from(module.order, growable: true);
                  module.order.add(order);
                  await isar.modules.put(module);
                });
              }
            }
            break;
          }
        }
      });
    } catch (e) {
        debugPrint(e.toString());
    }
  }

  Future<void> pushRecordsToDb() async {
    await isar.writeTxn(() async {
      // find ChildrenHealthData object by uid
      final childRecord = await isar.childrenHealthDatas.filter()
        .uidEqualTo(currChildID)
        .findFirst();

      if (childRecord != null) {
        // add storedRecords to the child record's medicalHistory

        childRecord.medicalHistory.medicalRecords = List.from(
          childRecord.medicalHistory.medicalRecords, growable: true
        ); // weird workaround to non-growable list bug

        childRecord.medicalHistory.medicalRecords.addAll(storedRecords);
        
        await isar.childrenHealthDatas.put(childRecord);
        debugPrint("Record/s succesfully added!");
      } else {
        // if none found
        debugPrint("No child found with uid: $currChildID");
      }
    });
  }

  void setSubModule( String? nextSubModule ) {
    subModule = nextSubModule;
    debugPrint("Next submodule: $subModule"); // D E B U G  PRINTING

    // if next submodule is a main question (part of module.order), push current record
    // to stored records and start a new record for the main question
    if (currModule!.order.contains(subModule)) {
      if (currRecord.records.isNotEmpty) { storedRecords.add(currRecord); }
      createMainQuestionRecord(); // (puts the new record as currRecord)
      debugPrint("created new mq record");
    }

    // special case to log general-module record properly
    if (subModule == "respond-main-menu") {
      storedRecords.add(currRecord);
      pushRecordsToDb();
    }

    SubModule next = currModule!.subModule.firstWhere((submodule) => submodule.name == nextSubModule);
    currSub = next;
    currQuestion = next.questionTranslation!.getTranslation(currLanguage)!;
    currAnswers = next.qckReply?.getTranslation(currLanguage);
    notifyListeners();
  }

  Future<void> setModule( String nextModule ) async {
    try {
      var module = await isar.modules.filter().nameEqualTo(nextModule).findFirst();
    
      if ( module != null && module.subModule.isNotEmpty) {
        currModule = module;
        // String? nextSubmodule = currModule?.order[0];
        // setSubModule(nextSubmodule);
      } else {
        currQuestion = "Filbis is thinking...";
        currAnswers = ["Retry"];
      }

    } catch (e) {
      debugPrint(e.toString());
      currQuestion = "Error loading question...";
      currAnswers = ["Retry"];
    }
    
  }

  // Sets the current module to the general module
  void setGeneral(String response) async {
    currQuestion = "Loading...";
    currAnswers = [];  
    String subName = "get-age";
    currAnswers = [];

    // if we're finished with a module, push stored records to db
    // (but add the last record to storedRecords first)
    storedRecords.add(currRecord);
    pushRecordsToDb();

    try {
      var module = await isar.modules.filter().nameEqualTo("general_module").findFirst();

      if (module != null && module.subModule.isNotEmpty) {
        currModule = module;
        // currSub = 2;
        // currSub = 4;
        currSub = module.subModule.firstWhere((subModule) => subModule.name == "respond-main-menu");

        // Update with actual values from the database
        // var sampleSub = module.subModule.firstWhere((submodule) => submodule.name == subName);
        // debugPrint(sampleSub.toString());
        currQuestion = currSub!.questionTranslation?.getTranslation(currLanguage) ?? "Filbis is thinking...";
        currAnswers = currSub!.qckReply?.getTranslation(currLanguage) ?? []; // Provide a default value or keep empty
      } else {

        currQuestion = "Filbis is thinking...";
        currAnswers = []; 
      }
    } catch (e) {
      // Handle any errors that occur during database access
      debugPrint(e.toString());
      currQuestion = "Error loading question";
      currAnswers = []; // Adjust based on the expected type
    }
    debugPrint("currQuestion: $currQuestion currAnswers: $currAnswers");
    notifyListeners();
  }

  // Display language question (not present in Firestore)
  void getLanguage() {
    currQuestion = "Anong lenguahe ang gagamitin natin? What language do you want to use? Unsa nga pinulongan ang gusto nimong gamiton?";
    currAnswers = ['Filipino', 'English', 'Cebuano'];
  }

  // Set language variable
  Future<void> setLanguage(String selLanguage) async {
    currLanguage = selLanguage;
    debugPrint(currLanguage);
    await setModule("general_module");
    setSubModule("get-privacy-policy");
    // setGeneral("test");
  }

  // Create medical record for child if one does not exist yet
  Future<void> checkChildRecord(String uid) async {
    await isar.writeTxn(() async {
      // Check if ChildrenHealthData object exists
      final record = await isar.childrenHealthDatas.filter()
        .uidEqualTo(uid)
        .findFirst();

      currChildID = uid;

      if (record == null) {
        // if does not exist, make and insert in db
        final newChildRecord = ChildrenHealthData()
          ..uid = uid
          ..medicalHistory = MedicalHistory();

        await isar.childrenHealthDatas.put(newChildRecord);
        debugPrint("created new child record");
      }
      else {
        debugPrint("child record already exists");
      }
    });
  }

  // Create a new response record for the appropriate main question 
  // (NOTE: should push record to db only once whole module is finished, otherwise discard)
  void createMainQuestionRecord() {
    currRecord = MedicalRecord()
      ..uid = "med_rec_${currModule?.name}_${formatDate(DateTime.now())}"
      ..createdAt = formatDate(DateTime.now())
      ..module = currModule!.name;
  }

  // After each submodule, store user response as a key-value pair in the medical record object
  void recordResponse(String choice) {
    debugPrint("data_key: ${currSub?.mobile?.dataKey}");
    debugPrint("currSub: ${currSub?.name}");

    // if data_key is not blank, store response in database
    if (currSub?.mobile?.dataKey != "") {
      final recordedResponse = KeyValuePair()..key = currSub?.mobile!.dataKey ?? ""..value = choice;
      debugPrint("logged: ${recordedResponse.key}, ${recordedResponse.value}");
      currRecord.records.add(recordedResponse);
    } 
    else { debugPrint("didn't store anything."); }
  }

  // formats a DateTime object as how dates are stored in webapp database
  // example format: (2024-07-09)-13:21:54:792
  String formatDate(DateTime date) {
    String newDate = "(${date.year}-${date.month}-${date.day})-${date.hour}:${date.minute}:${date.second}:${date.millisecond}";

    return newDate;
  }

   //Upload data to the web server
  static void uploadData() async {
    // get all data from the ChildrenHealthData

    var data = await isar.childrenHealthDatas.where().findAll();

    for (var child in data) {
      // upload the data to the web server
      for (var record in child.medicalHistory.medicalRecords) {
        //go through records and upload them
        var med_rec = {};

        med_rec["uid"] = child.uid;

        for (var pair in record.records) {
          if (pair.key == "uid"){
            med_rec["sessionID"] = pair.value;
          }
          med_rec[pair.key] = pair.value;
        }

        // send the data here


        // delete db data here
      print(med_rec);
      }

    }

    // upload the data to the web server
  }
}

  // void getQuestion() async {
  //   final module = await isar.modules.filter().nameEqualTo("general_module").findFirst();
  //   question = module!.subModule[currSub].questionTranslation!.english_response.toString();
  //   notifyListeners();
  // }