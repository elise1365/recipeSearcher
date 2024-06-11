import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recipe_thing/resultsPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpWidget.dart';
import 'signUpPage.dart';
import 'searchPage.dart';

class signIn extends StatefulWidget{

  @override
  State<signIn> createState() => signInState();
}

class signInState extends State<signIn>{

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext){
    return Scaffold(
        appBar: AppBar(
            actions: <Widget>[
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
        body: Center(
            child: Column(
                children: [
                  SizedBox(height: 140),
                  Text('Sign in', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 30))),
                  SizedBox(height: 20),
                  SizedBox(
                      width: 320,
                      child: TextField(
                          controller: myController,
                          style: GoogleFonts.lexend(textStyle: TextStyle()),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFFF5937A))),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFFF5937A))),
                              labelText: 'Email',
                              filled: true,
                              fillColor: Color(0xFFF5937A)
                          )
                      )
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      width: 320,
                      child: TextField(
                          controller: myController,
                          style: GoogleFonts.lexend(textStyle: TextStyle()),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8CBCB9))),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8CBCB9))),
                              labelText: 'Password',
                              filled: true,
                              fillColor: Color(0xFF8CBCB9)
                          )
                      )
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      width: 100,
                      height: 35,
                      child: TextButton(
                          child: Text('Done', style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.black, fontSize: 16))),
                          onPressed: (){

                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF8997D1)
                          )
                      )
                  ),
                  SizedBox(height: 10),
                  RichText(
                      text: TextSpan(
                          text: 'Sign up for an account',
                          style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => signUp())
                              );
                            },
                            children: [
                              TextSpan(
                                text: ' or ',
                                  style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 20))
                              ),
                              TextSpan(
                                text: 'back to search',
                                  style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20)),
                                  recognizer: TapGestureRecognizer()
                                  ..onTap = (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => searchPage())
                                    );
                                  }
                              )
                          ]
                      )
                  )
                ]
            )
        )
    );
  }
}