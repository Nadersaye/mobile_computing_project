import 'package:flutter/material.dart';
import 'package:mobile_computing_project/home.dart';


void main() {
  runApp(const TennisApp());
}
class TennisApp extends StatelessWidget {
  const TennisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tennis App',
      home: TennisGamePage(),
    );
  }
}
