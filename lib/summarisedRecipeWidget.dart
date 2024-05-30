import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class summarisedRecipe extends StatelessWidget {

  String title = '';
  String description = '';
  int time = 0;
  int price = 0;
  int difficulty = 0;
  List ingredients = [];
  List steps = [];

  summarisedRecipe({required this.title, required this.description, required this.time, required this.price, required this.difficulty, required this.ingredients, required this.steps});

  @override
  Widget build(BuildContext context) {
    String _ingredients = ingredients.toString();
    _ingredients = _ingredients.replaceAll('[', '');
    _ingredients = _ingredients.replaceAll(']', '');

    return SizedBox(
      width: 700,
      height: 150,
      child: Card(
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
                        ),),
                        SizedBox(width: 7)
                      ]
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
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
                        )
                      ]
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Flexible(
                          child: Text(overflow: TextOverflow.fade, softWrap: false, description,
                            style: GoogleFonts.lexend()
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
    );
  }

}
