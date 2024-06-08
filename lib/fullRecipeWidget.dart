import 'package:flutter/cupertino.dart';
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
                                  SizedBox(height: 20),
                                  Center(
                                    child: Container(
                                      width: 590,
                                      child:
                                      SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              children: [
                                                Text('Ingredients: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                                ...ingredients.map((ingredient) => Container(
                                                    height: 40,
                                                    child: Card(
                                                        elevation: 0,
                                                        child: Center(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 15, right: 15),
                                                            child: Text(ingredient, style: TextStyle(fontSize: 16))
                                                          )
                                                        )
                                                    )
                                                ))
                                              ]
                                          )
                                      )
                                    )
                                  ),
                                  SizedBox(height: 25),
                                  Center(
                                    child: Container(
                                      height: 370,
                                      width: 600,// specify the desired height
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
                                    )
                                  )
                                ]
                            ),
                            Positioned(
                                bottom: 10, left: 535, right: 0,
                                child:
                                Text.rich(
                                    TextSpan(
                                        text: 'Time: ',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        children: <TextSpan> [
                                          TextSpan(text: time.toString(), style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))),
                                          TextSpan(text: ' mins', style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)))
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