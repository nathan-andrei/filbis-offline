import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String child;
  final ValueChanged<String> onPressed;

  MyButton({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: ElevatedButton(
        onPressed: () {
          onPressed(child.toLowerCase());
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffed7402), // background color
          foregroundColor: Colors.white, // text color
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: 'Shrikhand',
            fontSize: 24,
          )
        ),
        child: Text(child),
      ),
    );
  }
}