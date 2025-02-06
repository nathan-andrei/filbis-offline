import 'package:filbis_offline/model/collections_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// https://api.flutter.dev/flutter/material/DropdownButton-class.html FOR REFERENCE

class LanguageDropDown extends StatefulWidget{
  final String passedChoice;

  //passedChoice is passed by the homepage so we can tell the dropdown
  //what was the first language picked
  const LanguageDropDown({required this.passedChoice, super.key});

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

const List<String> langChoices = ["Filipino", "English", "Cebuano"];

class _LanguageDropDownState extends State<LanguageDropDown>{
  late String currChoice;

  @override
  initState(){
    currChoice = widget.passedChoice[0].toUpperCase() + widget.passedChoice.substring(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 0, 0, 0),
      ),
      child: DropdownButton<String>( //Try different vals
        dropdownColor: const Color(0xffed7042),
        value: currChoice,
        icon: const Icon(Icons.arrow_downward, color: Colors.white),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: (String? value){
          setState(() {
            currChoice = value!;
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