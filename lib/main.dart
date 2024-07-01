// ignore_for_file: prefer_const_constructors

import 'package:filbis_offline/model/collections_controller.dart';
import 'package:filbis_offline/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
    // Initialize Database 
  WidgetsFlutterBinding.ensureInitialized();
  await FilbisDatabase.initIsar();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilbisDatabase())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: Homepage()
      ),
    );
  }
}