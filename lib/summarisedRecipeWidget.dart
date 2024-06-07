import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fullRecipeWidget.dart';

class summarisedRecipe extends StatelessWidget {

  String title = '';
  String description = '';
  int time = 0;
  List ingredients = [];
  List steps = [];

  summarisedRecipe({required this.title, required this.description, required this.time, required this.ingredients, required this.steps});

  @override
  Widget build(BuildContext context) {
    String _ingredients = ingredients.toString();
    _ingredients = _ingredients.replaceAll('[', '');
    _ingredients = _ingredients.replaceAll(']', '');

    return SizedBox(
          width: 600,
          height: 150,
          child: Card(
              color: Color(0xFF7087B6),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => fullRecipe(title: title, description: description, time: time, ingredients: ingredients, steps: steps))
                        );
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    children: [
                                      Text(title,
                                        style: GoogleFonts.lexend(
                                            textStyle: TextStyle(fontSize: 20)
                                        ))
                                    ]
                                ),
                                SizedBox(height: 7),
                                Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 500,
                                        child: Text(description,
                                            style: GoogleFonts.lexend()
                                        )
                                      )
                                    ]
                                ),
                                  SizedBox(height: 7),
                                  Row(
                                      children: [
                                        Container(
                                            width: 500,
                                            height: 22,
                                            child:
                                            Text.rich(
                                              TextSpan(
                                                text: 'Ingredients: ',
                                                style: GoogleFonts.lexend(
                                                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(text: _ingredients,
                                                    style: GoogleFonts.lexend(
                                                        textStyle: TextStyle(fontWeight: FontWeight.normal)
                                                    ),)
                                                ],
                                              ),
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                            )
                                        )
                                      ]
                                  ),
                                SizedBox(height: 7),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text.rich(
                                          TextSpan(
                                              text: 'Time: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              children: <TextSpan> [
                                                TextSpan(text: time.toString(), style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.normal))),
                                                TextSpan(text: ' mins', style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.normal)))
                                              ]
                                          )
                                      )
                                    ]
                                )
                              ]
                          )
                      )
              )
          )
      );
  }

}
