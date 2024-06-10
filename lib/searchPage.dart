import 'package:flutter/material.dart';
import 'resultsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpWidget.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => searchPageState();
}

class searchPageState extends State<searchPage> {

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: const Icon(Icons.help_outline),
                    onPressed: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => helpCard())
                      );
                    }
                )
              ]
            ),
            SizedBox(height: 200),
            Text('Welcome to Recipe Searcher', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            Text('Enter an ingredient and hit the search button!', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 20))),
            SizedBox(height: 20),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                          width: 250,
                          child: TextField(
                              controller: myController,
                              style: GoogleFonts.lexend(textStyle: TextStyle()),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFFF5937A))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFFF5937A))),
                                  hintText: 'Start typing...',
                                  filled: true,
                                  fillColor: Color(0xFFF5937A)
                              )
                          )
                    ),
                    IconButton(
                        icon: const Icon(Icons.search),
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
          ]
      ),
    );
  }
}