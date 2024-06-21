import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff337641),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 29, 77, 59),
          title: Container( 
            child: Row( 
              children: [ 
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset('assets/icons/icon-192.png',
                    height: 40,
                  ),
                ),

                const Text(
                  "FilBis",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Shrikhand',
                    fontSize: 24,
                  )
                )
              ],
            ),
          )
        ),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.75,
            heightFactor: 0.3,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff7cc089),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              height: 250,
              width: 300,
              padding: EdgeInsets.all(30),
              child: const Center(
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
      );
  }
}