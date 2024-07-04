import 'dart:convert';
import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/util/translation_extension.dart';
import 'package:flutter/material.dart'; 
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../util/translation_extension.dart';
import 'package:http/http.dart' as http;
 
class FilbisDatabase extends ChangeNotifier {
  static late Isar isar;

  // Variables for module display
  late Module? currModule; 
  late SubModule currSub;
  late String subModule;
  String currQuestion = "Filbis is thinking...";
  late List<String>? currAnswers = []; 
  late String currLanguage;
  bool haveLanguage = false;


  // Initializes IsarDB
  static Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ModuleSchema],
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
                mobile.dataKey = subModules[subKey]["mobile"]["data_key"];
                mobile.yesNext = subModules[subKey]["mobile"]["yes_next"];
                mobile.next = subModules[subKey]["mobile"]["next"];
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
          }
        }
      });
    } catch (e) {
        debugPrint(e.toString());
    }
  }

  void setSubModule( String nextSubModule ) {
    subModule = nextSubModule;
    SubModule next = currModule!.subModule.firstWhere((submodule) => submodule.name == nextSubModule);
    currQuestion = next.questionTranslation!.getTranslation(currLanguage)!;
    currAnswers = next.qckReply?.getTranslation(currLanguage);
    notifyListeners();
  }

  void setModule( String nextModule ) async {
    currModule = await isar.modules.filter().nameEqualTo(nextModule).findFirst();
    String nextSubmodule = currModule!.order[0];
    setSubModule(nextSubmodule);
  }

  // Sets the current module to the general module
  void setGeneral(String response) async {
    currQuestion = "Loading...";
    currAnswers = [];  
    String subName = "get-age";
    currAnswers = [];

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
        currQuestion = currSub.questionTranslation?.getTranslation(currLanguage) ?? "Filbis is thinking...";
        currAnswers = currSub.qckReply?.getTranslation(currLanguage) ?? []; // Provide a default value or keep empty
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

  void setLanguage(String selLanguage) {
    currLanguage = selLanguage;
    haveLanguage = true;

    setGeneral("test");
  }
}

  // void getQuestion() async {
  //   final module = await isar.modules.filter().nameEqualTo("general_module").findFirst();
  //   question = module!.subModule[currSub].questionTranslation!.english_response.toString();
  //   notifyListeners();
  // }




