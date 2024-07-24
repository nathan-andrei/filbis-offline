// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';

import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/util/checking.dart';
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

  // Checking internet connecion
  bool isConnectedToInternet = false;
  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    
    debugPrint("I N I T I A L I Z E D");
    context.read<FilbisDatabase>().getLanguage();
    super.initState();

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
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }


  // Based on the choice, determine the route to next question
  List<String> determineNext ( String choice, SubModule submodule, int length ) {
    final checkModule = VerifyNextReference();
    // debugPrint("Choice: $choice");
    late List<String> valuepair;
    debugPrint("Yes Bypass: $yesBypass");
    
    // Check if in check_Module.general_module
    if (checkModule.generalModule.containsKey(choice)) {
      if (checkModule.generalModule[choice]!.contains("_")) {   // Choice leads to a module
        currSubmoduleIndex = 0; // Reset index counter
        valuepair = ["Module", checkModule.generalModule[choice]!];

        if (valuepair[1] == "endocrine_module") currSubmoduleIndex = 1;

        debugPrint("FIRST IF: ${valuepair.toString()}");
        return valuepair;
      } 

      // Choice leads to a submodule within general module
      valuepair = ["Submodule", checkModule.generalModule[choice]!];
      debugPrint("SECOND IF: ${valuepair.toString()}");
      return valuepair; 
    }
    // Check if in yes_list 
    if (checkModule.checkTriggerFollowUp.contains(choice) || yesBypass == true) {
      debugPrint("Yes Bypass: $yesBypass");
      valuepair = ["Submodule", submodule.mobile!.yesNext!];

      // Choice is yes but no follow up
      if ( valuepair[1] == "") {
        valuepair[1] = submodule.mobile!.next!;
      }

      // Follow up question choice is yes and it is the final F-U question
      if ( valuepair[1] == "END" && currSubmoduleIndex < length) currSubmoduleIndex++; 
      debugPrint("THIRD IF: ${valuepair.toString()}");
      return valuepair;
    }

    // Return next submodule reference
    valuepair = ["Submodule", submodule.mobile!.next!];

    if ( valuepair[1] == "END" && currSubmoduleIndex < length) currSubmoduleIndex++;
  

    debugPrint("FOURTH IF: ${["Submodule", submodule.mobile!.next].toString()}");
    return valuepair; 

  }

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

      debugPrint("Yes Bypass: $yesBypass");
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

  void goNext ( String choice ) async {
    var FilbisDB = context.read<FilbisDatabase>();
    var currModule = FilbisDB.currModule;
    String uid = "-";

    if (choice == ""){
      debugPrint("Empty choice");
      var question = FilbisDB.currQuestion!;
      if (!question.contains("Please enter a valid response.")) {
        question = "Please enter a valid response. $question";
        FilbisDB.currQuestion = question;
        FilbisDB.refresh();
      }
      return;
    }

    var subModule = FilbisDB.subModule!;
    // insert heart and lungs bypass here
    heartLungsModuleBypass(currModule, choice, subModule);

    if ( subModule == "get-sex" ) gender = choice;

    List<String> nextRoute = determineNext(choice, FilbisDB.currSub!, currModule!.order.length);
    // debugPrint(nextRoute.toString());
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

    debugPrint("Choice: $choice");

    try {
      if ( nextRoute[0] == "Module" ) {
        await FilbisDB.setModule(nextRoute[1]);
        String? nextSubmodule = FilbisDB.currModule?.order[0] ?? "";
        debugPrint(FilbisDB.currModule!.order.toString());

        // Endocrine check
        if (nextRoute[1] == "endocrine_module" && gender == "male") {
          nextSubmodule = FilbisDB.currModule?.order[1] ?? "";
        }
 
        FilbisDB.setSubModule(nextSubmodule);
        // debugPrint("currSubModuleIndex: $currSubmoduleIndex"); // D E B U G  PRINT
        return;
      } 
      
      // In a follow-up question, go to next follow up
      if ( nextRoute[0] == "Submodule" && nextRoute[1] != "END" ) {
        if (!mounted) return;
        FilbisDB.setSubModule(nextRoute[1]);
        // debugPrint("currSubModuleIndex: $currSubmoduleIndex"); // D E B U G  PRINT
        return;
      }

      // Route to next submodule question, works regardless if coming from follow-up or not 
      if ( currSubmoduleIndex < currModule.order.length ) {
        yesBypass = false;
        FilbisDB.setSubModule(currModule.order[currSubmoduleIndex]);
        return;
      }

      // End of main submodule, go back to general module
      yesBypass = false;
      debugPrint("Finished Submodule");
      // debugPrint("currSubModuleIndex: $currSubmoduleIndex"); // D E B U G  PRINT
      FilbisDB.setGeneral("general-module");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void returnResponse(String choice) {
    if (haveLanguage) {
      goNext(choice.toLowerCase());
    }
    else {
      context.read<FilbisDatabase>().setLanguage(choice.toLowerCase());
      haveLanguage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff337641),
      appBar: AppBar(
        title: const Text(
          "FilBis",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Shrikhand',
            fontSize: 24,
          )
        ),
        backgroundColor: const Color.fromARGB(255, 29, 77, 59),
        leading: SvgPicture.asset(
          'assets/images/dlsu-logo.svg',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () => _showDownloadDialog(context),
          ),
          IconButton(
            icon: Icon(
              Icons.restart_alt,
              color: Colors.white
            ),
            onPressed: () { context.read<FilbisDatabase>().setGeneral("test");},
          ),
        ],
      ),
      body: ModulePage(onButtonPressed: returnResponse),
    );
  }

  void _showDownloadDialog(BuildContext context) {
    if (isConnectedToInternet) {
      _showConfirmationDialog(context);
    } else {
      // Show dialog that there is no internet connection
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection '),
            content: const Text('Please connect to the internet to download the latest data.'),
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
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text('Do you want to download the latest data?'),
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
                _showLoadingDialog(context);
                _initDb(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
    await FilbisDatabase.initDb();

    // Close the loading dialog
    Navigator.of(context).pop();
  }
}