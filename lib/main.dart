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
          leading: Image.asset(
            'assets/icons/icon-192.png',
            height: 100,
            width: 100, 
          )
        ),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.75,
            heightFactor: 0.3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff7cc089),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              height: 250,
              width: 300,
              padding: EdgeInsets.all(30),
              child: Center(
                child: Text(
                  "Hi! This is sample text.",
                  style: TextStyle(
                    color: Color(0xfff4e8d8),
                    fontFamily: 'GoogleSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )
                ),
              )
            ),
          )
        )
      ),
    );
  }
}