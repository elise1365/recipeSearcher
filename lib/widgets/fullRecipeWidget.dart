import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpWidget.dart';
import 'package:recipe_thing/dbFunctions.dart';

class fullRecipe extends StatefulWidget{
  String title = '';
  String description = '';
  int time = 0;
  List ingredients = [];
  List steps = [];
  int id = 0;

  fullRecipe({required this.title, required this.description, required this.time, required this.ingredients, required this.steps, required this.id});

  @override
  State<fullRecipe> createState() => fullRecipeState();
}

class fullRecipeState extends State<fullRecipe> {
  bool isFilled = false;

  void toggleIcon() {
      isFilled = !isFilled;
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String description = widget.description;
    int time = widget.time;
    List ingredients = widget.ingredients;
    List steps = widget.steps;

    return Stack(
      children: [
        Center(
          child: Column(
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
              SizedBox(
                  width: 700,
                  height: 600,
                  child: Card(
                    color: Color(0xFFC27684),
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
                                                      Text('Ingredients: ', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                                      ...ingredients.map((ingredient) => Container(
                                                          height: 40,
                                                          child: Card(
                                                              elevation: 0,
                                                              child: Center(
                                                                  child: Padding(
                                                                      padding: EdgeInsets.only(left: 15, right: 15),
                                                                      child: Text(ingredient, style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16)))
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
                                                                child: Text((index + 1).toString(), style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16)))
                                                            )
                                                        )
                                                    ),
                                                    Expanded(
                                                        child: Card(
                                                          elevation: 0,
                                                          child: ListTile(
                                                            title: Text(steps[index], style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16))),
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
                                right: 10,
                                  child: IconButton(
                                    icon: Icon(isFilled ? Icons.star : Icons.star_border_outlined),
                                    onPressed: (){
                                      setState(() {
                                        toggleIcon();
                                        addRecipeToUserFavourites(widget.id);
                                      });
                                    }
                                  )
                              ),
                              Positioned(
                                  bottom: 10, left: 535, right: 0,
                                  child:
                                  Text.rich(
                                      TextSpan(
                                          text: 'Time: ',
                                          style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          children: <TextSpan> [
                                            TextSpan(text: time.toString(), style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16), )),
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
            ]
          )
        ),
      ],
    );
  }

}