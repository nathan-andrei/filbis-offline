// ignore_for_file: prefer_const_constructors

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
  bool haveLanguage = false;

  @override
  void initState() {
    debugPrint("I N I T I A L I Z E D");
    context.read<FilbisDatabase>().getLanguage();
    //context.read<FilbisDatabase>().setGeneral(language);
    super.initState();
  }

  // Based on the choice, determine the route to next question
  List<String> determineNext ( String choice, SubModule submodule ) {
    final checkModule = VerifyNextReference();
    debugPrint("Choice: ${choice}");
    late List<String> valuepair;
    // Check if in check_Module.general_module
    if (checkModule.generalModule.containsKey(choice)) {
      if (checkModule.generalModule[choice]!.contains("_")) {   // Choice leads to a module
        valuepair = ["Module", checkModule.generalModule[choice]!];
        debugPrint("FIRST IF: ${valuepair.toString()}");
        return valuepair;
      } 
      valuepair = ["SubModule", checkModule.generalModule[choice]!];
      debugPrint("SECOND IF: ${valuepair.toString()}");
      return valuepair; // Choice leads to a submodule
    }
    // Check if in yes_list 
    if (checkModule.checkTriggerFollowUp.contains(choice)) {
      valuepair = ["Submodule", submodule.mobile!.yesNext!];
      debugPrint("THIRD IF: ${valuepair.toString()}");
      return valuepair;
    }

    // Return next submodule reference
    debugPrint("FOURTH IF: ${["Submodule", submodule.mobile!.next].toString()}");
    return ["Submodule", submodule.mobile!.next!]; 

  }

  void goNext ( String choice ) async {
    SubModule submodule = context.read<FilbisDatabase>().currSub!;
    List<String> nextRoute = determineNext(choice, submodule);
    debugPrint(nextRoute.toString());
    try {
      if (nextRoute[0] == "Module") {
        await context.read<FilbisDatabase>().setModule(nextRoute[1]);
      } else {
        context.read<FilbisDatabase>().setSubModule(nextRoute[1]);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

  }



  void returnResponse(String choice) {
    if (haveLanguage) {
      goNext(choice);
    }
    else {
      context.read<FilbisDatabase>().setLanguage(choice);
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
            onPressed: () {},
          ),
        ],
      ),
      body: ModulePage(onButtonPressed: returnResponse),
    );
  }
}