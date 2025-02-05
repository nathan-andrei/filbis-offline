// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';

import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/util/checking.dart';
import 'package:filbis_offline/widgets/lang_dropdown.dart';
import 'package:filbis_offline/widgets/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool haveLanguage = false; // Check if the session has a set language
  int currSubmoduleIndex = 0; // variable for current subodule index, helps for going back from a follow up Q
  String school = "";
  String idNum = "";
  String gender = "female";
  bool yesBypass = false;
  List<List<String>> prevModules = [];  //Array that holds all previous questions/modules; Resets everytime it hits respond-main-menu
                                        //The last element of prevModules in runtime is the current module!                     

  // Checking internet connecion
  bool isConnectedToInternet = false;
  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    
    debugPrint("I N I T I A L I Z E D");

    _internetConnectionStreamSubscription = 
      InternetConnection().onStatusChange.listen((event) {
        debugPrint(event.toString());
        switch (event) {
          case InternetStatus.connected:
            setState(() {
              isConnectedToInternet = true; 
            });
            break;

          case InternetStatus.disconnected: 
            setState(() {
              isConnectedToInternet = false; 
            });
            break;

          default: 
            setState(() {
              isConnectedToInternet = false; 
            });
            break;
        }
      });

    _checkDatabase(context);

    context.read<FilbisDatabase>().getLanguage();
    super.initState();
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  //HeartLungsModule works differently so it uses the function after this one (heartsLungModuleBypass)
  // Based on the choice, determine the route to next question
  List<String> determineNext ( String choice, SubModule submodule, int length ) {
    final checkModule = VerifyNextReference();
    late List<String> valuepair;
    
    debugPrint("choice: $choice");
    debugPrint("length: $length");
    debugPrint("Previous modules: $prevModules");
    //debugPrint("current Language: ${context.read<FilbisDatabase>().currLanguage}");

    // Check if in check_Module.general_module
    if (checkModule.generalModule.containsKey(choice)) {
      if (checkModule.generalModule[choice]!.contains("_")) {   // Choice leads to a module
        currSubmoduleIndex = 0; // Reset index counter
        valuepair = ["Module", checkModule.generalModule[choice]!];

        if (valuepair[1] == "endocrine_module") currSubmoduleIndex = 1;

        //Going to allergy_module puts you through here

        //Add module to prevModules array
        setState(() => prevModules.add(valuepair));
        debugPrint("[1]Current prev list: $prevModules");
        debugPrint("FIRST IF: ${valuepair.toString()}");
        return valuepair;
      } 

      // Choice leads to a submodule within general module
      valuepair = ["Submodule", checkModule.generalModule[choice]!];

      //Add module to prevModules array
      setState(() => prevModules.add(valuepair));
      debugPrint("[2]Current prev list: $prevModules");

      debugPrint("SECOND IF: ${valuepair.toString()}");
      return valuepair; 
    }
    // Check if in yes_list 
    if (checkModule.checkTriggerFollowUp.contains(choice) || yesBypass == true) {
      debugPrint("Yes Bypass: $yesBypass");

      //Return next submodule reference
      debugPrint("Module: $submodule");
      debugPrint("${submodule.mobile}");

      valuepair = ["Submodule", submodule.mobile!.yesNext!];

      // Choice is yes but no follow up
      if ( valuepair[1] == "") {
        valuepair[1] = submodule.mobile!.next!;
      }

      // Follow up question choice is yes and it is the final Follow-up question
      if ( valuepair[1] == "END") {
        if (currSubmoduleIndex < length){ currSubmoduleIndex++;}
        // go to end response
        if (currSubmoduleIndex == length) { valuepair[1] = context.read<FilbisDatabase>().getEndResponse();}
      }

      //Add module to prevModules array
      setState(() => prevModules.add(valuepair));
      debugPrint("[3]Current prev list: $prevModules");

      debugPrint("THIRD IF: ${valuepair.toString()}");
      return valuepair;
    }

    //Return next submodule reference
    debugPrint("Module: $submodule");
    debugPrint("${submodule.mobile}");
    valuepair = ["Submodule", submodule.mobile!.next!];

    if ( valuepair[1] == "END") {
      debugPrint("currSubmoduleIndex: $currSubmoduleIndex");
        if (currSubmoduleIndex < length){ currSubmoduleIndex++;}
        // go to end response
        if (currSubmoduleIndex == length) { valuepair[1] = context.read<FilbisDatabase>().getEndResponse(); }
    } 

    //Add module to prevModules array
    setState(() => prevModules.add(valuepair));
    debugPrint("[4]Current prev list: $prevModules");

    debugPrint("FOURTH IF: ${["Submodule", submodule.mobile!.next].toString()}");
    return valuepair; 

  }

  //heartLungsModule is setup differently, so it goes through here instead of the above function
  void heartLungsModuleBypass (var currModule, var choice, var subModule) {
    if (currModule!.name == "heart_lungs_module") {
      //avoid food and drink confirm-avoiding-food-and-drink
      //number eat/drink probiotic > 1 count-drinks-amount
      // situps > 1 count-situps-amount
      // taken antidep confirm-anxiety-remedy-medicine
      // breathing exer > 1 count-breathing-exercises-amount
      // massaged > 1 count-massaged-muscle-amount
      // warm shower > 1 count-shower-amount
      // painkillers confirm-spasm-remedy-medicine
      
      const subModulesToCheck = ["confirm-avoiding-food-and-drinks", "count-drinks-amount", 
                                "count-situps-amount", "confirm-anxiety-remedy-medicine", "count-breathing-exercises-amount",
                                "count-massaged-muscle-amount", "count-shower-amount", "confirm-spasm-remedy-medicine"];

      debugPrint("Yes Bypass heartlung: $yesBypass");
      debugPrint("In heartLungsModule");
      if (subModulesToCheck.contains(subModule) && yesBypass == false) {
        const noFlags = ["0", "dili", "wala", "no", "not sure", "hindi"];
        for (var flag in noFlags) {
          yesBypass = true;
          if(choice.contains(flag)){
            yesBypass = false;
            break;
          } else if (!choice.contains(flag) && subModule == "confirm-avoiding-food-and-drinks") {
            yesBypass = true;
            break;
          }
        }
      }
    }
  }

  //determines which module comes next
  void goNext ( String choice ) async {
    var FilbisDB = context.read<FilbisDatabase>();
    // if currModule is not initialized, return
    if (FilbisDB.currModule == null) {
      _checkDatabase(context);
      return;
    }

    var currModule = FilbisDB.currModule;
    String uid = "-";

    debugPrint("Choice: $choice");

    if (choice == ""){
      debugPrint("Empty choice");
      var question = FilbisDB.currQuestion!;
      if (!question.contains("Please enter a valid response.")) {
        String replacement;
        String currLanguage = context.read<FilbisDatabase>().currLanguage;

        if(currLanguage == "english"){
          replacement = "Please enter a valid response.";
        }
        else if(currLanguage == "filipino"){
          replacement = "Magsulat ng maayos na sagot.";
        }
        else{
          replacement = "Dili sakto ang iyong tubag. Palihug i-type utro.";
        }
        question = "$replacement $question";
        FilbisDB.currQuestion = question;
        FilbisDB.refresh();
      }
      return;
    }

    FilbisDB.storeCondition(choice);

    var subModule = FilbisDB.subModule!;
    heartLungsModuleBypass(currModule, choice, subModule);

    if ( subModule == "get-sex" ) gender = choice;
    debugPrint("gender: $gender");

    List<String> nextRoute;

    //This block handles backtracking
    if(choice == "prev"){
      debugPrint("prev detected");

      List<List<String>> prevModulesTemp = [];
      //Remove 2 modules from array when about to come out of a module. Idk if it's still needed since we reset everytime we go to main menu.
      if(prevModules[prevModules.length - 2][0] == "Module"){
        //Removes the current submodule and the module marker which does nothing
        prevModulesTemp = prevModules.sublist(0, prevModules.length - 2);
      }
      else{
        //Removes the current submodule
        prevModulesTemp = prevModules.sublist(0, prevModules.length - 1);
      }

      setState(() => prevModules = prevModulesTemp);
      nextRoute = prevModules[prevModules.length - 1]; //Set the previous submodule as the next route.
      debugPrint("[goNext] prevModules: $prevModules");
    }
    else{
      //If the choice is normal, proceed as normal.
      debugPrint("not prev");
      nextRoute = determineNext(choice, FilbisDB.currSub!, currModule!.order.length);
    }

    // END yes bypass as it has been used
    if (subModule == "count-situps-amount" || subModule == "count-breathing-exercises-amount" || subModule == "confirm-spasm-remedy-medicine") {
        yesBypass = false;
    }

    // RESPONSE HANDLING
    debugPrint("nextRoute: ${nextRoute[1]}");
    if (nextRoute[1] == "get-student-id") { // if submitted school
      school = choice;
      debugPrint("logged school: $school");
    }
    else if (nextRoute[1] == "get-sex") { // if submitted id
      idNum = choice;
      debugPrint("logged id: $idNum");

      uid = '$school-$idNum';
      debugPrint("uid: $uid");

      // check if record exists for curr school + id combo. if none, make one
      context.read<FilbisDatabase>().checkChildRecord(uid);
    }

    // before going to the next q, record current response to current 
    // record that's being constructed
    context.read<FilbisDatabase>().recordResponse(choice);

    // END - RESPONSE HANDLING
    try {
      if ( nextRoute[0] == "Module" ) {
        //Since submodules are determined by the module, this block handles that.
        await FilbisDB.setModule(nextRoute[1]);
        String? nextSubmodule = FilbisDB.currModule?.order[0] ?? "";
        debugPrint(FilbisDB.currModule!.order.toString());
        late List<String> valuepair;

        // Endocrine check
        if (nextRoute[1] == "endocrine_module" && (gender == "male" || gender == "lalaki")) {
          nextSubmodule = FilbisDB.currModule?.order[1] ?? "";
        }
        
        //Add the determined submodule to the prevModules.
        valuepair = ["Submodule", nextSubmodule];
        setState(() => prevModules.add(valuepair));
        debugPrint("[Module tracker] Previous modules: $prevModules");
        FilbisDB.setSubModule(nextSubmodule);
        return;
      } 
      
      if ( nextRoute[0] == "Submodule" && nextRoute[1] != "END" && nextRoute[1] != "FIN") {
        if (!mounted) return;

        //Coming back from any physical module, set it back to general_module.
        if(choice == "prev" && (nextRoute[1] == "respond-physical-menu" || nextRoute[1] == "respond-main-menu" || nextRoute[1] == "respond-mental-menu")){
          await FilbisDB.setModule("general_module");
        }
        FilbisDB.setSubModule(nextRoute[1]);
        return;
      }
      
      // Route to next submodule question, works regardless if coming from follow-up or not 
      if ( currSubmoduleIndex < currModule!.order.length ) {
        yesBypass = false;
        FilbisDB.setSubModule(currModule.order[currSubmoduleIndex]);
        return;
      }

      // End of main submodule, go back to general module
      yesBypass = false;
      debugPrint("Finished Submodule");
      setState(() => prevModules = [["Submodule", "respond-main-menu"]]);
      debugPrint("prevModules cleared!");
      // debugPrint("currSubModuleIndex: $currSubmoduleIndex"); // D E B U G  PRINT
      FilbisDB.setGeneral("general_module");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Handles setting of language if not set.
  void returnResponse(String choice) {
    if (haveLanguage) {
      goNext(choice.toLowerCase());
    }
    else {
      context.read<FilbisDatabase>().setLanguage(choice.toLowerCase());
      haveLanguage = true;
      setState(() => haveLanguage = true);
    }
  }

  @override
  Widget build(BuildContext context) { //Header
    return Scaffold(
      backgroundColor: const Color(0xffefe0db),
      appBar: AppBar(
        backgroundColor: const Color(0xffed7042),
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/images/dost-seal.svg',
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/dlsu-logo.svg',
              ),
            ),
          ],
        ),
        title: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: const Text(
              "FilBis",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Shrikhand',
              ),
            ),
          ),
        ),
        actions: [
          prevModules.length > 1 ?
            IconButton(  //THE BACK BUTTON
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white
              ),
              onPressed: () => returnResponse("PREV")
            )
            : Container(),
          haveLanguage ? 
            LanguageDropDown(passedChoice: context.read<FilbisDatabase>().currLanguage) //THE LANGUAGE SELECTOR
            : Container(),
          IconButton(
            icon: Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () => _showDownUploadDialog(context, true),
          ),
          IconButton(
            icon: Icon(
              Icons.upload,
              color: Colors.white
            ),
            onPressed: () => _showDownUploadDialog(context, false),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.white
            ),
            onPressed: () => _showLogOutDialog(context, true),
          ),
          IconButton(
            icon: Icon(
              Icons.restart_alt,
              color: Colors.white
            ),
            onPressed: () => _showLogOutDialog(context, false),
          ),
        ],
      ),
      body: ModulePage(onButtonPressed: returnResponse),
    );
  }

  //ALL THE FUNCTIONS OF THE HOMEPAGE BUTTONS
  void _showDownUploadDialog(BuildContext context, bool download) {
    if (isConnectedToInternet) {
      _showConfirmationDialog(context, download);
    } else {
      _showNoInternetDialog(context, download);
    }
  }

  Future<void> _checkDatabase(BuildContext context) async {
    bool isEmpty = await FilbisDatabase.isDatabaseEmpty();
    if (isEmpty) {
      if(isConnectedToInternet) {
        _showEmptyDatabaseDialog(context);
      } else {
        _showNoInternetAndEmptyDbDialog(context);
      }
    }
    return;
  }

  void _showEmptyDatabaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Empty Database'),
          content: const Text('The database is empty. Please download the latest data.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showLoadingDialog(context, true);
              },
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }

  void _showNoInternetAndEmptyDbDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Download required'),
          content: const Text('Please connect to the internet to download the latest data.'),
          actions: [
            TextButton(
              onPressed: () {
                if (isConnectedToInternet) {
                  Navigator.of(context).pop();
                  _showLoadingDialog(context, true);
                }
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  void _showNoInternetDialog(BuildContext context, bool download) {
    String dialog = "Please connect to the internet to ";
    if (download) {
      dialog += "download the latest data.";
    } else {
      dialog += "upload the data.";
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection'),
            content: Text(dialog),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
  }

  void _showConfirmationDialog(BuildContext context, bool download) {
    String dialog = "Do you want to ";
    if (download) {
      dialog += "download the latest data?";
    } else {
      dialog += "upload the data?";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: Text(dialog),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                _showLoadingDialog(context, download);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showLoadingDialog(BuildContext context, bool download) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (download) {
          _initDb(context);
        } else {
          _uploadData(context);
        }
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 15),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _initDb(BuildContext context) async {
    // Simulate a network request or any async task
    bool success = await FilbisDatabase.initDb();

    // Close the loading dialog
    if (mounted){
      Navigator.of(context, rootNavigator: true).pop();
      if (success) {
        _showSuccessDialog(context);
      } else {
        _showFailDialog(context);
      }
    }
  }

  Future<void> _uploadData(BuildContext context) async {
    // Simulate a network request or any async task
    int status = await FilbisDatabase.uploadData();

    // Close the loading dialog
    if (mounted) {
      debugPrint("Status: $status");
      Navigator.of(context, rootNavigator: true).pop();
      if (status == 0) {
        _showFailDialog(context);
      } else if (status == 1) {
        _showNotificationDialog(context, "Some records failed to upload.", "Please try again later","OK");
      } else if (status == 2) {
        _showSuccessDialog(context);
      } else {
        _showNotificationDialog(context, "No data to upload.", "a","OK");
      }
    }
  }

  void _showNotificationDialog(BuildContext context, String title, String content, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('You are good to go!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showFailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('An error occurred'),
          content: const Text('Oops! Something went wrong. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  
  void _showLogOutDialog(BuildContext context, bool clearData) {
    var title = "Log Out";
    var content = "Are you sure you want to log out";
    if (clearData) {
      title += " and Clear Children Data";
      content += " and clear all children data";
    }
    content += "?";


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (clearData) {
                  FilbisDatabase.clearChildrenData();
                }
                context.read<FilbisDatabase>().logOut();
                haveLanguage = false;
                setState(() => haveLanguage = false);
                currSubmoduleIndex = 0; 
                school = "";
                idNum = "";
                gender = "female";
                yesBypass = false;
                setState(() => prevModules = []);
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}