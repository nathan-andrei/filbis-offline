// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:filbis_offline/classes/button.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/util/answers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var _loadedData = {};
    var answers = {};
    var _buttons = [ // temp test, (_buttons) should be (answers)
      'Filipino',
      'English',
      'Cebuano',
    ];


    Future<void> readJson() async {
      final String response = await rootBundle.loadString('assets/files/sample.json');
      final data = await json.decode(response);
      setState(() {
        _loadedData = data["q1"];
      });
    }    
    
    @override
    void initState() {
      readJson();
      FilbisDatabase.initDb();
      super.initState();
    }
    
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
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: [
              Spacer(flex: 1,),
              const Text(
                "Kumusta ka? Gusto kong magpakilala sa iyo. Isa akong Nurse Bot. Ang pangalan ko ay si Fil-Bis.",
                style: TextStyle(
                  color: Color(0xfff4e8d8),
                  fontFamily: 'GoogleSans',
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80,),
              Image.asset(
                'assets/icons/icon-325.png', 
                width: 150,
                height: 75,
              ),
              FractionallySizedBox(
                widthFactor: 0.75,
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
                        const Text(
                          "Pumili ng isa sa mga opsyon o magtype sa chatbox.",
                          style: TextStyle(
                            color: Color(0xfff4e8d8),
                            fontFamily: 'GoogleSans',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          )
                        ),
                        SizedBox(height: 15,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _buttons.length,
                            itemBuilder: (context, index) {
                              return MyButton(child: _buttons[index],);
                            }
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      )
    );
  }
}