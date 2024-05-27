import 'package:flutter/material.dart';
import 'searchPage.dart';
import 'resultsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Searcher',
      debugShowCheckedModeBanner: false,
      home: resultsPage(inputText: 'hello'),
    );
  }
}


