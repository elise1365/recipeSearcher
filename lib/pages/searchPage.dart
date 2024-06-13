import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'resultsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/helpWidget.dart';
import 'signUpPage.dart';
import 'signInPage.dart';

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
            SizedBox(height: 180),
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
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8997D1))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8997D1))),
                                  hintText: 'Start typing...',
                                  filled: true,
                                  fillColor: Color(0xFF8997D1)
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
                    ),
                  ]
              ),
            SizedBox(height: 20),
            RichText(
                text:
                TextSpan(
                    text: 'Create an account ',
                    style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                signUp())
                        );
                      },
                  children:[
                    TextSpan(
                      text: 'to favourite recipes',
                        style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 20))
                    )
                  ]
                ),
            ),
            RichText(
              text:
              TextSpan(
                text: 'Sign in',
                style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20)),
                recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            signIn())
                    );
                  },
              ),
            )
          ],
      ),
    );
  }
}