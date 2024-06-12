import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpWidget.dart';
import 'signInPage.dart';
import 'searchPage.dart';
import 'favouritesPage.dart';

class signUp extends StatefulWidget{

  @override
  State<signUp> createState() => signUpState();
}

class signUpState extends State<signUp>{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            Text('Create an account', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 30))),
            SizedBox(height: 20),
            SizedBox(
                width: 320,
                child: TextField(
                    controller: emailController,
                    style: GoogleFonts.lexend(textStyle: TextStyle()),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8CBCB9))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8CBCB9))),
                        labelText: 'Email',
                        filled: true,
                        fillColor: Color(0xFF8CBCB9)
                    )
                )
            ),
            SizedBox(height: 10),
            SizedBox(
                width: 320,
                child: TextField(
                    controller: passwordController,
                    style: GoogleFonts.lexend(textStyle: TextStyle()),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFFF5937A))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFFF5937A))),
                        labelText: 'Password',
                        filled: true,
                        fillColor: Color(0xFFF5937A)
                    )
                )
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 100,
              height: 35,
              child: TextButton(
                  child: Text('Done', style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.black, fontSize: 16))),
                  onPressed: () async {
                    try {
                      // Attempt to sign in the user
                      final response = await Supabase.instance.client.auth.signUp(
                          email: emailController.text,
                          password: passwordController.text
                      );

                      final User? user = response.user;
                      if (user != null) {
                        print('Sign in successful');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => favouritesPage())
                        );
                      } else {
                        print('Sign in unsuccessful');
                        // showWidget();
                      }
                    } catch (error) {
                      print('Sign in unsuccessful: $error');
                      // showWidget();
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF8997D1)
                  )
              )
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                    text: 'Sign in',
                    style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20)),
                    recognizer: TapGestureRecognizer()
                    ..onTap = (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signIn())
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