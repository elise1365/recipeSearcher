import 'package:flutter/material.dart';
import 'resultsPage.dart';
import 'package:google_fonts/google_fonts.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => searchPageState();
}

class searchPageState extends State<searchPage> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter an ingredient'
                  )
              )
            ),
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Click to start the search',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        resultsPage(inputText: myController.text))
                );
              }
            )
          ]
        )
      ),
    );
  }
}