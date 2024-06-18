import 'package:recipe_thing/dbFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/searchPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class logOutButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Log out'),
      onPressed: () {
        Supabase.instance.client.auth.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => searchPage())
        );
      }
    );
  }
}