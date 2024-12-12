import 'package:filbis_offline/widgets/button.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

/*
class ModulePage extends StatefulWidget {
  final ValueChanged<String> onButtonPressed;

  const ModulePage({required this.onButtonPressed, super.key});

  @override
  State<ModulePage> createState() => _ModuleState();
}*/

/*
class DropDownButtonApp extends StatelessWidget{
  const DropDownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Choose Language')),
        body: const Center(
          child: DropdownButton
        ),
      )
    );
  }
}*/


// https://api.flutter.dev/flutter/material/DropdownButton-class.html FOR REFERENCE
class LanguageDropDown extends StatefulWidget{
  String currChoice;

  //currChoice is passed by the homepage so we can tell the dropdown
  //what was the first language picked
  LanguageDropDown({required this.currChoice, super.key});

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();

  set CurrChoice(String val) => currChoice = val;
}

const List<String> langChoices = ["Filipino", "English", "Cebuano"];

class _LanguageDropDownState extends State<LanguageDropDown>{

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 0, 0, 0),
      ),
      child: DropdownButton<String>( //Try different vals
        dropdownColor: const Color(0xffed7042),
        value: widget.currChoice[0].toUpperCase() + widget.currChoice.substring(1),
        icon: const Icon(Icons.arrow_downward, color: Colors.white),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: (String? value){
          setState(() {
            widget.currChoice = value!;
          });
          context.read<FilbisDatabase>().setLanguage(value!.toLowerCase(), false);
        },
        items: langChoices.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value)
          );
        }).toList(),
      )
    );
  }
}