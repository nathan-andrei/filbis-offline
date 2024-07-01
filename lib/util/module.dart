import 'package:filbis_offline/model/collections_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Module extends StatelessWidget {
  const Module({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(50.0),  
        child: ListView.builder(
          itemCount: 3,
            itemBuilder: (context, index) {
              context.watch<FilbisDatabase>().getQuestion();
              var question = context.watch<FilbisDatabase>().question;
              return Text(question);
            })
        );
  }
}


// Module -> submodule 