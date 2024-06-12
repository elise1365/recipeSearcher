import 'searchPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpWidget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'summarisedRecipeWidget.dart';

class favouritesPage extends StatefulWidget{
  List recipeIds = [];

  favouritesPage({required this.recipeIds});

  @override
  State<favouritesPage> createState() => favouritesPageState();
}

class favouritesPageState extends State<favouritesPage>{
  @override
  Widget build(BuildContext){
    final _future = Supabase.instance.client
        .from('Recipes')
        .select();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Favourite recipes', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 40)))),
        actions: [
          IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => helpCard())
                );
              }
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if (!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }
                final recipes = snapshot.data!;
                return
                  SingleChildScrollView(
                      child: Center(
                          child: Column(
                              children: [
                                SizedBox(height: 20),
                                    Container(
                                      height: 580,
                                        width: 550,
                                        child: ListView.builder(
                                            itemCount: recipes.length,
                                            itemBuilder: ((context, index){
                                              final recipe = recipes[index];
                                              String title = recipe['title'];
                                              String description = recipe['description'];
                                              List<dynamic> ingredients = recipe['ingredients'];
                                              List<dynamic> steps = recipe['steps'];
                                              int time = recipe['time'];
                                              return summarisedRecipe(
                                                  title: title,
                                                  description: description,
                                                  time: time,
                                                  ingredients: ingredients,
                                                  steps: steps);
                                            })
                                        )
                                    )
                              ]
                          )
                      )
                  );
              }
          )
          ]
        )
      )
    );
  }
}