// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:filbis_offline/classes/button.dart';
import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/util/answers.dart';
import 'package:filbis_offline/util/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    late String language; 

    var _buttons = [ // temp test, (_buttons) should be (answers)
      'Filipino',
      'English',
      'Cebuano',
    ];

    @override
    void initState() {
      FilbisDatabase.initDb();
      super.initState();
    }

    void setLanguage (language) {
      setState(() {
        language = language;
      });
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
      body: Module(),
    );
  }
}