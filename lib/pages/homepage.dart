// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/util/checking.dart';
import 'package:filbis_offline/widgets/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
  bool yesBypass = false;

  @override
  void initState() {
    debugPrint("I N I T I A L I Z E D");
    context.read<FilbisDatabase>().getLanguage();
    super.initState();
  }

  // Based on the choice, determine the route to next question
  List<String> determineNext ( String choice, SubModule submodule, int length ) {
    final checkModule = VerifyNextReference();
    debugPrint("Choice: $choice");
    late List<String> valuepair;
    
    // Check if in check_Module.general_module
    if (checkModule.generalModule.containsKey(choice)) {
      if (checkModule.generalModule[choice]!.contains("_")) {   // Choice leads to a module
        currSubmoduleIndex = 0; // Reset index counter
        valuepair = ["Module", checkModule.generalModule[choice]!];
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
      yesBypass = false;
      return valuepair;
    }

    // Return next submodule reference
    valuepair = ["Submodule", submodule.mobile!.next!];

    if ( valuepair[1] == "END" && currSubmoduleIndex < length) currSubmoduleIndex++;
  

    debugPrint("FOURTH IF: ${["Submodule", submodule.mobile!.next].toString()}");
    return valuepair; 

  }

  void goNext ( String choice ) async {
    var FilbisDB = context.read<FilbisDatabase>();
    var currModule = FilbisDB.currModule;
    String uid = "-";
    List<String> nextRoute = determineNext(choice, FilbisDB.currSub!, currModule!.order.length);
    // debugPrint(nextRoute.toString());
    
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

  //ADD heart and lungs shit here
    if (currModule.name == "heart_lungs_module") {
      //avoid food and drink confirm-avoiding-food-and-drink
      //number eat/drink probiotic > 1 count-drinks-amount
      // situps > 1 count-situps-amount
      // taken antidep confirm-anxiety-remedy-medicine
      // breathing exer > 1 count-breathing-exercises-amount
      // massaged > 1 count-massaged-muscle-amount
      // warm shower > 1 count-shower-amount
      // painkillers confirm-spasm-remedy-medicine
      
      const subModulesToCheck = ["confirm-avoiding-food-and-drink", "count-drinks-amount", 
                                "count-situps-amount", "confirm-anxiety-remedy-medicine", "count-breathing-exercises-amount",
                                "count-massaged-muscle-amount", "count-shower-amount", "confirm-spasm-remedy-medicine"];

      var subModule = FilbisDB.subModule!;

      if (subModulesToCheck.contains(subModule)) {
        const noFlags = ["0", "dili", "wala", "no", "not sure", "hindi"];
        for (var flag in noFlags) {
          if (!choice.contains(flag)) {
            yesBypass = true;
            break;
          }
        }
      }
    }

    // before going to the next q, record current response to current 
    // record that's being constructed
    context.read<FilbisDatabase>().recordResponse(choice);

    // END - RESPONSE HANDLING

    debugPrint("Choice: $choice");

    try {
      if ( nextRoute[0] == "Module" ) {
        await FilbisDB.setModule(nextRoute[1]);
        debugPrint("currSubModuleIndex: $currSubmoduleIndex"); // D E B U G  PRINT
        return;
      } 
      
      // In a follow-up question, go to next follow up
      if ( nextRoute[0] == "Submodule" && nextRoute[1] != "END" ) {
        if (!mounted) return;
        FilbisDB.setSubModule(nextRoute[1]);
        debugPrint("currSubModuleIndex: $currSubmoduleIndex"); // D E B U G  PRINT
        return;
      }

      // Route to next submodule question, works regardless if coming from follow-up or not 
      if ( currSubmoduleIndex < currModule.order.length ) {
        FilbisDB.setSubModule(currModule.order[currSubmoduleIndex]);
        yesBypass = false;
        return;
      }

      // End of main submodule, go back to general module
      debugPrint("Finished Submodule");
      // // Route back to main submodule from follow up 
      // if (nextRoute[1] == "END" && currSubmoduleIndex < FilbisDB.currModule!.order.length-1 ) {
      //   FilbisDB.setSubModule(FilbisDB.currModule!.order[currSubmoduleIndex]);
      // }

      // // Route back to general from finishing submodule
      // if (nextRoute[1] == "END" && currSubmoduleIndex == FilbisDB.currModule!.order.length-1) {
      //   currSubmoduleIndex = 0; 
      //   debugPrint("goNext: Finished Submodule"); // D E B U G  PRINT
      //   FilbisDB.setGeneral("general_module");
      // }
      debugPrint("currSubModuleIndex: $currSubmoduleIndex"); // D E B U G  PRINT
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
            onPressed: FilbisDatabase.initDb,
          ),
          IconButton(
            icon: Icon(
              Icons.restart_alt,
              color: Colors.white
            ),
            onPressed: FilbisDatabase.uploadData,
          ),
        ],
      ),
      body: ModulePage(onButtonPressed: returnResponse),
    );
  }
}