import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpWidget.dart';

class signUp extends StatefulWidget{

  @override
  State<signUp> createState() => signUpState();
}

class signUpState extends State<signUp>{

  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
          title: Text('Sign up'),
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
      )
    );
  }
}