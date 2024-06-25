import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String choice;
  Function()? onPress;
  
  Answer({super.key, 
  required this.onPress, 
  required this.choice
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton( 
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffed7402), // background color
        foregroundColor: Colors.white, // text color
        elevation: 0,
        textStyle: const TextStyle(
          fontFamily: 'Shrikhand',
        )
      ),
      child: Text(choice),
    );
  }
}
