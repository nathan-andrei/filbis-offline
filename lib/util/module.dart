import 'package:filbis_offline/classes/button.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Module extends StatelessWidget {
  const Module({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController _textController = TextEditingController();

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
                  color: Color(0xfff4e8d8),
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
                                  controller: _textController,
                                  decoration: const InputDecoration( 
                                    hintText: "Type",
                                    border: OutlineInputBorder()
                                  ),
                                );
                              }
                              // debugPrint(" H E R E ");
                              return MyButton(child: answers[index]);
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

// Padding(
//         padding: const EdgeInsets.all(50.0),
//         child: Center(
//           child: Column(
//             children: [
//               Spacer(flex: 1,),
//               const AutoSizeText(
//                 "Kumusta ka? Gusto kong magpakilala sa iyo. Isa akong Nurse Bot. Ang pangalan ko ay si Fil-Bis.",
//                 textAlign: TextAlign.center,
//                 maxLines: 3,
//                 minFontSize: 18,
//                 overflow: TextOverflow.fade,
//                 style: TextStyle(
//                   color: Color(0xfff4e8d8),
//                   fontFamily: 'GoogleSans',
//                   fontSize: 36,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Spacer(flex: 1,),
//               Image.asset(
//                 'assets/icons/icon-325.png', 
//                 width: 150,
//                 height: 75,
//               ),
//               FractionallySizedBox(
//                 widthFactor: 0.85,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Color(0xff7cc089),
//                     borderRadius: BorderRadius.all(Radius.circular(20))
//                   ),
//                   height: 250,
//                   width: 300,
//                   padding: const EdgeInsets.all(30),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         FittedBox(
//                           fit: BoxFit.contain,
//                           child: const Text(
//                             "Pumili ng isa sa mga opsyon o magtype sa chatbox.",
//                             style: TextStyle(
//                               color: Color(0xfff4e8d8),
//                               fontFamily: 'GoogleSans',
//                               fontSize: 26,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: _buttons.length,
//                             itemBuilder: (context, index) {
//                               return MyButton(child: _buttons[index],);
//                             }
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ),
//               ),
//               Spacer(flex: 2,),
//             ],
//           ),
//         ),
//       )
// Module -> submodule 