import 'package:filbis_offline/widgets/button.dart';
import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/util/checking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Module extends StatefulWidget {
  final ValueChanged<String> onButtonPressed;

  const Module({required this.onButtonPressed, super.key});

  @override
  State<Module> createState() => _ModuleState();
}

class _ModuleState extends State<Module> {
  final TextEditingController textController = TextEditingController();
  String nextReference = "";


  // Based on the choice, determine the route to next question
  List<String> determineNext ( String choice, SubModule submodule ) {
    final checkModule = VerifyNextReference();

    // Check if in check_Module.general_module
    if (checkModule.generalModule.containsKey(choice)) {
      if (checkModule.generalModule[choice]!.contains("_")) {   // Choice leads to a module
        return ["Module", checkModule.generalModule[choice]!];
      } 
      return ["SubModule", checkModule.generalModule[choice]!]; // Choice leads to a submodule
    }
    // Check if in yes_list 
    if (checkModule.yes_Reference.contains(choice)) {
      return ["Submodule", submodule.mobile!.yesNext!];
    }

    // Return next submodule reference
    return ["Submodule", submodule.mobile!.next!]; 
  }

  void goNext ( String choice ) {
    SubModule submodule = context.read<FilbisDatabase>().currSub;
    List<String> nextRoute = determineNext(choice, submodule);

    if (nextRoute[0] == "Module") {
      context.read<FilbisDatabase>().setModule(nextRoute[1]);
    } else {
      context.read<FilbisDatabase>().setSubModule(nextRoute[1]);
    }

  }



  @override
  Widget build(BuildContext context) {


    return Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: [
              Spacer(flex: 1,),
              AutoSizeText(
                context.read<FilbisDatabase>().currQuestion,
                textAlign: TextAlign.center,
                maxLines: 3,
                minFontSize: 18,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: Color.fromARGB(255, 126, 119, 110),
                  fontFamily: 'GoogleSans',
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(flex: 1,),
              Image.asset(
                'assets/icons/icon-325.png', 
                width: 150,
                height: 75,
              ),
              FractionallySizedBox(
                widthFactor: 0.85,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff7cc089),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  height: 250,
                  width: 300,
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Column(
                      children: [
                        const FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Pumili ng isa sa mga opsyon o magtype sa chatbox.",
                            style: TextStyle(
                              color: Color(0xfff4e8d8),
                              fontFamily: 'GoogleSans',
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: context.watch<FilbisDatabase>().currAnswers!.isEmpty ? 1 : context.watch<FilbisDatabase>().currAnswers!.length ,
                            itemBuilder: (context, index) {
                              final filbisDB = context.watch<FilbisDatabase>();
                              final answers = filbisDB.currAnswers ?? [];
                              // debugPrint("SAMPLE");
                              if ( answers.isEmpty ) {
                                // debugPrint("HERE");
                                return TextField( 
                                  controller:  textController,
                                  decoration: const InputDecoration( 
                                    hintText: "Type",
                                    border: OutlineInputBorder()
                                  ),
                                );
                              }
                              // debugPrint(" H E R E ");
                              return MyButton(child: answers[index], onPressed: widget.onButtonPressed,);
                            }
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              Spacer(flex: 2,),
            ],
          ),
        ),
      );
  }
}

