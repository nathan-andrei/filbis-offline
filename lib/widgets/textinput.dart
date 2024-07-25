import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final ValueChanged<String> onPress;

  const TextInputWidget({ required this.textController,
                    required this.onPress,
                    super.key
          });

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: [ 
        Expanded(
          flex: 1,
          child: TextField(
            controller: textController, 
            decoration: const InputDecoration( 
              hintText: "Type Here",
              border: OutlineInputBorder()
            )
          ),
        ),
        IconButton(
          onPressed: () {
            var userInput = textController.text; 
            textController.clear();
            onPress(userInput);
          }, 
          icon: const Icon(Icons.send_rounded, color: Color(0xffed7402),))
      ],
    );
  }
}