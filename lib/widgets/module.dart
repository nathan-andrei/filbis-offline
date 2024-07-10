import 'package:filbis_offline/widgets/button.dart';
import 'package:filbis_offline/model/collections.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/util/checking.dart';
import 'package:filbis_offline/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ModulePage extends StatefulWidget {
  final ValueChanged<String> onButtonPressed;

  const ModulePage({required this.onButtonPressed, super.key});

  @override
  State<ModulePage> createState() => _ModuleState();
}

class _ModuleState extends State<ModulePage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: [
              Spacer(flex: 1,),
              AutoSizeText(
                context.read<FilbisDatabase>().currQuestion!,
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
                                return TextInputWidget(textController: textController, onPress: widget.onButtonPressed);
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

