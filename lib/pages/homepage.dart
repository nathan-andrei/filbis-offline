// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:filbis_offline/model/collections_controller.dart';
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

  void returnResponse(String response) {
    haveLanguage ? context.read<FilbisDatabase>().setGeneral(response) : 
                   context.read<FilbisDatabase>().setLanguage(response);
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
      body: Module(onButtonPressed: returnResponse),
    );
  }
}