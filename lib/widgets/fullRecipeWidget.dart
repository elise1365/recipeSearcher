import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpWidget.dart';
import 'package:recipe_thing/dbFunctions.dart';
import 'ingredientWidget.dart';

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
  bool? _isFavourite;
  late Future<bool> isFavouriteFuture;

  @override
  void initState() {
    super.initState();
    isFavouriteFuture = _fetchIsFavorite();
  }

  Future<bool> _fetchIsFavorite() async {
    return await isAlreadyInFavourites(widget.id);
  }

  void toggleFavourite(){
    setState(() {
      if (_isFavourite == true) {
        removeRecipeFromUserFavourites(widget.id);
        _isFavourite = false;
      } else {
        addRecipeToUserFavourites(widget.id);
        _isFavourite = true;
      }
    });
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
                    color: Color(0xFFAA80B3),
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
                                                          child: ingredientCard(ingredientName: ingredient),
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
                                  child:FutureBuilder<bool>(
                                    future: isFavouriteFuture,
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.done){
                                        if(snapshot.hasData){
                                          _isFavourite ??= snapshot.data!;
                                          return IconButton(
                                              icon: Icon(_isFavourite! ? Icons.done : Icons.add),
                                              onPressed: toggleFavourite
                                          );
                                        }
                                        else if (snapshot.hasError){
                                          return IconButton(
                                              icon: Icon(_isFavourite! ? Icons.done : Icons.add),
                                              onPressed: toggleFavourite
                                          );
                                        }
                                      }
                                      return SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(),
                                      );
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