// ignore_for_file: prefer_const_constructors

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
              Image.asset(
                'assets/icons/icon-515.png', 
                width: 221.5,
                height: 203,
              ),

              SizedBox(height: 30,),
              
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AutoSizeText(
                    context.read<FilbisDatabase>().currQuestion!,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    minFontSize: 14,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Color(0xff312828),
                      fontFamily: 'GoogleSans',
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              
              Expanded(
                child: Container(
                  // decoration: const BoxDecoration(
                  //   color: Colors.black,
                  // ),
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: context.watch<FilbisDatabase>().currAnswers!.isEmpty ? 1 : context.watch<FilbisDatabase>().currAnswers!.length ,
                            itemBuilder: (context, index) {
                              final filbisDB = context.watch<FilbisDatabase>();
                              final answers = filbisDB.currAnswers ?? [];
                              
                              if ( answers.isEmpty ) {
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
            ],
          ),
        ),
      );
  }
}

