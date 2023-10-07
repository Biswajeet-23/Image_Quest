import 'package:flutter/material.dart';
import 'screens/image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ImageSearchApp(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 199, 216),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}