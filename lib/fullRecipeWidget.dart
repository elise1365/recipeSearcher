import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class fullRecipe extends StatelessWidget {

  String title = '';
  String description = '';
  int time = 0;
  List ingredients = [];
  List steps = [];

  fullRecipe({required this.title, required this.description, required this.time, required this.ingredients, required this.steps});

  @override
  Widget build(BuildContext context) {
    String _ingredients = ingredients.toString();
    _ingredients = _ingredients.replaceAll('[', '');
    _ingredients = _ingredients.replaceAll(']', '');

    return Stack(
      children: [
        Center(
            child: SizedBox(
                width: 700,
                height: 600,
                child: Card(
                  color: Color(0xFFA1B0CE),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Stack(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        Text(title,
                                          style: GoogleFonts.lexend(
                                              textStyle: TextStyle(fontSize: 30)
                                          ),)
                                      ]
                                  ),
                                  SizedBox(height: 25),
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
                                  SizedBox(height: 25),
                                  Container(
                                    height: 350, // specify the desired height
                                    child: ListView.builder(
                                      itemCount: steps.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                            children: [
                                              SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Card(
                                                      elevation: 0,
                                                      child: Center(
                                                        child: Text((index + 1).toString())
                                                      )
                                                  )
                                                ),
                                              Expanded(
                                                  child: Card(
                                                    elevation: 0,
                                                    child: ListTile(
                                                      title: Text(steps[index]),
                                                    ),
                                                  )
                                              )
                                            ]
                                        );
                                        },
                                    ),
                                  ),
                                ]
                            ),
                            Positioned(
                                bottom: 10, left: 550, right: 0,
                                child:
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
                            )
                          ]
                        )
                    ),
                )
            )
        ),
      ],
    );
  }

}