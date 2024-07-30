import 'dart:convert';
import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/util/translation_extension.dart';
import 'package:flutter/material.dart'; 
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:math';
 
class FilbisDatabase extends ChangeNotifier {
  static late Isar isar;

  // Variables for module display
  String? currQuestion = "Filbis is thinking...";
  late Module? currModule; 
  late SubModule? currSub;
  late String? subModule;
  late List<String>? currAnswers = []; 
  late List<String>? currAnswersEng = [];
  late MedicalRecord currRecord = MedicalRecord();
  late String currChildID = "";
  late String currLanguage;
  int emergencyFlag = 0;
  List<String> conditions = [];

  static String webServer = "https://healthbotapi-ntt4zfqcuq-as.a.run.app";

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
  static Future<bool> initDb() async {
    try {
      var url = Uri.parse('$webServer/mobile_download_modules');
      // var url = Uri.http('10.0.2.2:8000', '/mobile_download_modules');
      var response = await http.post(url, body: {});
      var data = json.decode(response.body);
      // for each module in the data, add it to the database
      // wipe the database first
      await isar.writeTxn(() async {
        await isar.modules.where().deleteAll();
      });

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
            if (subKey != 'ache_associations') {
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
          }
          break;
        }
      }
    } catch (e) {
        debugPrint(e.toString());
        return false;
    }

    debugPrint("Database initialized");
    return true;
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

        emergencyFlag = max(physicalFlagging(storedRecords), emergencyFlag);
        childRecord.medicalHistory.medicalRecords.addAll(storedRecords);
        
        await isar.childrenHealthDatas.put(childRecord);
        debugPrint("Record/s succesfully added!");
      } else {
        // if none found
        debugPrint("No child found with uid: $currChildID");
      }
    });
    storedRecords.clear();
  }

  void setSubModule( String? nextSubModule ) async {
    subModule = nextSubModule;
    debugPrint("Next submodule: $subModule"); // D E B U G  PRINTING

    // if next submodule is a main question (part of module.order), push current record
    // to stored records and start a new record for the main question
    if (currModule!.order.contains(subModule) || subModule!.startsWith("confirm-symptom")) {
      debugPrint(storedRecords.length.toString());
      if (currRecord.uid != "") { storedRecords.add(currRecord); }
      debugPrint(storedRecords.length.toString());

      createMainQuestionRecord(); // (puts the new record as currRecord)
      debugPrint("created new mq record");
    }

    // special case to log general-module record properly
    if (subModule == "respond-main-menu") {
      storedRecords.add(currRecord);
      debugPrint(storedRecords.length.toString());
      await pushRecordsToDb();
      currRecord = MedicalRecord();
      debugPrint("after pushing: ${storedRecords.length.toString()}");
    }

    SubModule next = currModule!.subModule.firstWhere((submodule) => submodule.name == nextSubModule);
    currSub = next;
    currQuestion = next.questionTranslation!.getTranslation(currLanguage)!;
    currAnswers = next.qckReply?.getTranslation(currLanguage);
    currAnswersEng = next.qckReply?.englishReplies;
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
    debugPrint(storedRecords.length.toString());
    await pushRecordsToDb();
    debugPrint("after pushing: ${storedRecords.length.toString()}");

    try {
      await setModule("general_module");
      setSubModule("respond-main-menu");
    
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
    var time = DateTime.now();
    currRecord = MedicalRecord()
      ..uid = "med_rec_${currModule?.name}_${formatDate(time)}"
      ..createdAt = formatDate2(DateTime.now())
      ..updatedAt = formatDate2(DateTime.now())
      ..module = currModule!.name
      ..mainQuestion = subModule!;
  }

  // After each submodule, store user response as a key-value pair in the medical record object
  void recordResponse(String choice) {
    int index = -1; // index of choice for translating for data storing
    debugPrint("data_key: ${currSub?.mobile?.dataKey}");
    debugPrint("currSub: ${currSub?.name}");

    if (currAnswers!.isNotEmpty) { 
      for ( int i = 0; i < currAnswers!.length; i++) { 
        if ( currAnswers![i].toLowerCase() == choice ) {
          index = i;
          break;
        }
      }

    } 

    // Translate the choice into english for storing
    debugPrint("currAnswers: $currAnswers Index: $index");
    if ( index >= 0 ) {
      debugPrint("currAnswersEng: $currAnswersEng");
      choice = currAnswersEng![index].toLowerCase();
    }

    // if data_key is not blank, store response in database
    if (currSub != null) {
      if (currSub!.mobile!.dataKey != "" && currSub!.mobile!.dataKey != null) {
        final recordedResponse = KeyValuePair()..key = currSub!.mobile!.dataKey!..value = choice;
        debugPrint("logged: ${recordedResponse.key}, ${recordedResponse.value}");
        currRecord.records.add(recordedResponse);
      } 
      else { debugPrint("didn't store anything."); }
    }
  }

  // formats a DateTime object as how dates are stored in webapp database
  // example format: (2024-07-09)-13:21:54:792
  String formatDate(DateTime date) {
    String newDate = "(${date.year}-${date.month}-${date.day})-${date.hour}:${date.minute}:${date.second}:${date.millisecond}";

    return newDate;
  }

  //format a DateTime object
  // example format: Jul 09, 2024 at 12:21:54.792 PM UTC+8
  String formatDate2 (DateTime date) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    final String formatted = formatter.format(date);

    if (date.hour < 12) {
      return "$formatted at ${date.hour}:${date.minute}:${date.second}.${date.millisecond} AM UTC+8";
    } else {
      return "$formatted at ${date.hour-12}:${date.minute}:${date.second}.${date.millisecond} PM UTC+8";
    }
  }

   //Upload data to the web server
  static Future<int> uploadData() async {
    // get all data from the ChildrenHealthData

    var data = await isar.childrenHealthDatas.where().findAll();
    int count = 0;
    int errCount = 0;
    for (var child in data) {
      // upload the data to the web server
      for (var record in child.medicalHistory.medicalRecords) {
        count++;
        //go through records and upload them
        var medRec = {};

        medRec["childID"] = child.uid;
        medRec["recordID"] = record.uid;
        medRec["module"] = record.module;
        medRec["created_at"] = record.createdAt;
        medRec["object"] = record.mainQuestion;

        for (var pair in record.records) {
            medRec[pair.key] = pair.value;
        }

        // send the data here
        var uri = Uri.parse("$webServer/mobile_upload_modules");
        // var uri = Uri.http('10.0.2.2:8000', '/mobile_upload_modules');
        var response = await http.post(uri, body: jsonEncode(medRec));
        if (response.statusCode == 200) {
          // delete the record from the database
          await isar.writeTxn(() async {
            final childData = await isar.childrenHealthDatas.filter().uidEqualTo(child.uid).findFirst();
            if (childData != null) {
              final modifiableMedicalRecords = List<MedicalRecord>.from(childData.medicalHistory.medicalRecords);
              final medicalRecordIndex = modifiableMedicalRecords.indexWhere((record2) => record2.uid == record.uid);
              if (medicalRecordIndex != -1) {
                modifiableMedicalRecords.removeAt(medicalRecordIndex);
                childData.medicalHistory.medicalRecords = modifiableMedicalRecords;
                await isar.childrenHealthDatas.put(childData);
              }
            }
          });
        } else {
          errCount++;
        }
      }
    }

    if (errCount == count && count != 0) {
      debugPrint("All records failed to upload");
      return 0;
    } else if (errCount > 0) {
      debugPrint("Some records failed to upload");
      return 1;
    } else if (errCount == 0 && count > 0) {
      debugPrint("All records uploaded successfully");
      return 2;
    } else {
      debugPrint("No records to upload");
      return 3;
    }
  }

  void refresh() {
    notifyListeners();
  }

  static Future<bool> isDatabaseEmpty() async {    
    return (await isar.modules.where().findAll()).isEmpty;
  }

  static Future<void> clearChildrenData() async {
    await isar.writeTxn(() async {
      await isar.childrenHealthDatas.where().deleteAll();
    });
  }

  int physicalFlagging(List<MedicalRecord> records) {
    var yesNoKeys = ['fever-is-on-off','has-experienced-extremeheadache','has-any-form-of-discharge','discharge-hasfoulsmell','had-inserted-object-into-ear','has-pain','has-loss-of-sight','stomach-flu-had-chills','stomach-flu-experienced-dehydration','stomach-flu-food-had-different-smell-or-taste','stomach-flu-experienced-vomitting','rushed-to-hospital','had-blindness','had-experienced-dizziness','had-vomitted','had-passed-out','head-x-confirmation','is-recurring','ache-x-confirmation','heart-lungs-x-confirmation','experienced-shortness-of-breath','hospitalized-due-to-heart-related-issues','mtth-x-confirmation','had-difficult-time-chewing','has-pain-in-the-nose','nosepain-is-recurring','had-insertedobject-into-nose','has-experienced-pain-while-urinating','eyep-x-confirmation','earp-x-confirmation'];
    var countKeys = ['stomach-flu-vomit-count', 'bowel-times-a-day', 'stomach-flu-boweltimes'];
    var pain_scale_keys = ['stomach-flu-painintensity', 'pain-intensity', 'swelling-painintensity', 'menstrual-pain-intensity', 'stomach-flu-painintensity', 'urine-pain-intensity', 'discomfortability', 'pain-intensity-due-to-inserted-object'];
    var temperature_keys = ['current-temperature', 'highest-temperature'];
    
    var time_keys = ['duration', 'duration-of-object-in-nose', 'duration-of-nose-pain'];
    var time_weights = {'7 hours': 1, '8 hours': 2, '1 day': 3, '3 days': 4, '1 week': 5, '2 weeks': 6};

    var choice_effect_keys = ['side-effects'];
    var choice_color_keys = ['phlegm-color', 'spit-appearance', 'poop-color', 'frequent-urine-color'];

    for (var medicalRecord in records) {
      if(medicalRecord.module != "mental_health_module" && medicalRecord.module != "general_module") {
        // for each record in medical_records.records
        if (medicalRecord.records.length > 1) {
          for (final record in medicalRecord.records) {
            if (yesNoKeys.contains(record.key)) {
              try {
                if (medicalRecord.mainQuestion != "confirm-ears-fungal-infection" && medicalRecord.mainQuestion != "confirm-head-injury") {
                  if (['yes', 'sometimes'].contains(record.value)){
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  }
                }
              } catch (e) {
                if (['yes', 'sometimes'].contains(record.value)) {
                  medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                  return 1;
                }
              }
            }

            if (countKeys.contains(record.key)) {
              try{
                if (record.key == 'stomach-flu-vomit-count' && int.parse(record.value) >= 3) {
                  medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                  return 1;
                } else if (int.parse(record.value) >= 4) {
                  medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                  return 1;
                }
              } catch (e) {
                // do nothing
              }
            }

            if (pain_scale_keys.contains(record.key)) {
              try {
                if (int.parse(record.value) >= 8) {
                  medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                  return 1;
                }
              } catch (e) {
                // do nothing
              }
            }

            if (temperature_keys.contains(record.key)) {
              try {
                if (float.parse(record.value) >= 39.5) {
                  medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                  return 1;
                }
              } catch (e) {
                // do nothing
              }
            }

            if (time_keys.contains(record.key)) {
              try {
                if (record.key == "duration") {
                  var module = medicalRecord.module;
                  if (module == "buto_and_muscle_module" && time_weights['3 days']! <= time_weights[record.value]!) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  } else if (module == "cough_and_cold_module" && time_weights['2 weeks']! <= time_weights[record.value]!) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  } else if (module == "heart_and_lungs_module" && time_weights['1 day']! <= time_weights[record.value]!) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  }
                } else {
                  if (record.key == 'duration-of-object-in-nose' && time_weights['1 day']! <= time_weights[record.value]!) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  }
                  
                  if (time_weights['3 days']! <= time_weights[record.value]!) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  }
                }
              } catch (e) {
                // do nothing
              }
            }

            if (choice_effect_keys.contains(record.key)) {
              try {
                if (medicalRecord.module == 'allergy_module') {
                  if (['nausea and vomiting', 'difficulty breathing'].contains(record.value)) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  }
                }
              } catch (e) {
                // do nothing
              }
            }

            if (choice_color_keys.contains(record.key)) {
              try {
                if (medicalRecord.module == 'gu_module') {
                  if (['brownish', 'bloody red'].contains(record.value)) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  }

                  if (['black', 'red', 'brown'].contains(record.value)) {
                    medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "1");
                    return 1;
                  }
                }
              } catch (e) {
                // do nothing
              }
            }
          }
          medicalRecord.records.add(KeyValuePair()..key = "total_emergency_flag_score" .. value = "0");
        }
      }
    }
    return 0;
  }

  void getEndResponse(){
    if (currModule != null) {
      switch(currModule!.name) {
        case "allergy_module":
        // any of the confirms
          if (emergencyFlag == 1) {
            // go to severe
          } else if (conditions.isEmpty) {
            // go to healthy
          } else {
            // go to custom
          }
          break;
        case "buto_and_muscle_module":
        // any of the confirms
          if (conditions.isEmpty) {
            // go to healthy
          } else if (emergencyFlag == 1) {
            // go to severe
          } else if (conditions.contains('confirm-bone-pain-sitting') && conditions.contains('confirm-bone-pain-standing') && conditions.contains('confirm-bone-pain-walking')){
            // go to custom_all
          } else if (conditions.contains('confirm-bone-pain-sitting')){
            // go to custom_seated
          } else if (conditions.contains('confirm-bone-pain-standing') || conditions.contains('confirm-bone-pain-walking')){
            // go to custom_walkrun
          }
          break;
        case 'cough_and_cold_module':
          //go to cc_response
          break;
        case 'daily_living_scale_module':
        // any of the confirms
          if (conditions.isEmpty) {
            //go to healthy
          } else {
            // go to custom
          }
          break;
        case 'ear_module':
          if (emergencyFlag == 1) {
            // go to severe
          } else {
            // go to healthy
          }
          break;
        case 'endocrine_module':
          if (emergencyFlag == 1) {
            // go to severe
          } else {
            // go to custom
          }
          break;
        case 'eyes_module':
        // loss of sight
          if (conditions.isEmpty) {
            // go to healthy
          } else {
            // go to custom
          }
          break;
        case 'family_history_module':
          if (conditions.isEmpty) {
            // go to healthy
          } else {
            // go to custom
          }
          break;
        case 'gi_module':
          if (emergencyFlag == 1) {
            // go to severe
          } else {
            // go to healthy
          }
          break;
        case 'gu_module':
        // urinate pain
          if (emergencyFlag == 1) {
            // go to severe
          } else {
            // go to healthy
          }
          break;
        case 'head_module':
          if (emergencyFlag == 1) {
            // go to severe
          } else if (conditions.contains('confirm-head-injury')) {
            // go to custom
          } else {
            // go to healthy
          }
          break;
        case 'heart_and_lungs_module':
        // any confirm
          if (conditions.isEmpty) {
            // go to healthy
          } else {
            // go to diagnosis
          }
          break;
        case 'immunization_module':
          // confirms - opposite
          if (conditions.isEmpty) {
            // go to healthy
          } else {
            // go to custom
          }
          break;
        case 'mouth_throat_teeth_module':
          // confirms
          if (conditions.isEmpty) {
            // go to healthy
          } else {
            // go to custom
          }
          break;
        case 'nose_module':
          // losta shit a goin down
          break;
        case 'skin_module':
          // confirms
          if (conditions.isEmpty) {
            //healthy
          } else {
            //bad
          }
          break;

      }
    }
    emergencyFlag = 0;
    conditions = []; 
  }

  void logOut() {
    getLanguage();
    // clear other vars
    currRecord = MedicalRecord();
    currChildID = "";
    currModule = null; 
    currSub = null;
    subModule = null;
    emergencyFlag = 0;
    conditions = [];
    currLanguage = "";
    notifyListeners();
  }
}