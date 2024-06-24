// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff337641),
        appBar: AppBar(
          title: Text(
            "FilBis",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Shrikhand',
              fontSize: 24,
            )
          ),
          backgroundColor: Color.fromARGB(255, 29, 77, 59),
          leading: SvgPicture.asset(
            'assets/images/dlsu-logo.svg',
          )
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Kumusta ka? Gusto kong magpakilala sa iyo. Isa akong Nurse Bot. Ang pangalan ko ay si Fil-Bis.",
                  style: TextStyle(
                    color: Color(0xfff4e8d8),
                    fontFamily: 'GoogleSans',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  'assets/icons/icon-325.png', 
                  width: 150,
                  height: 150,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff7cc089),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 250,
                    width: 300,
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Hi! This is sample text.",
                            style: TextStyle(
                              color: Color(0xfff4e8d8),
                              fontFamily: 'GoogleSans',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )
                          ),
                          ElevatedButton(
                            onPressed: () {}, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffed7402), // background color
                              foregroundColor: Colors.white, // text color
                              elevation: 0,
                              textStyle: TextStyle(
                                fontFamily: 'Shrikhand',
                              )
                            ),
                            child: Text("Filipino"),
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}