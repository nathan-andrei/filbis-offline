import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: [
              const Text(
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
                            backgroundColor: const Color(0xffed7402), // background color
                            foregroundColor: Colors.white, // text color
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontFamily: 'Shrikhand',
                            )
                          ),
                          child: const Text("Filipino"),
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
    );
  }
}