import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class displayErrorMessage extends StatelessWidget{
  String errorMessage = '';

  displayErrorMessage({required this.errorMessage});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 60,
      child: Center(
          child: Card(
              color: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(errorMessage, style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16, color: Colors.white)))
            )
          )
        )
    );
  }

}