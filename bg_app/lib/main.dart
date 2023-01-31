import 'package:bg_app/views/homepage.dart';
import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FLUTTER BACKGROUND REMOVERAPP",
      theme: ThemeData(primarySwatch: Colors.teal),
      home: EditorHome(),
    );
  }
}
