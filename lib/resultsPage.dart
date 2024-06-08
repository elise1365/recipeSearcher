import 'package:flutter/material.dart';
import 'searchPage.dart';
import 'summarisedRecipeWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

String _inputText = '';

class resultsPage extends StatefulWidget {
  String inputText = '';

  resultsPage({required this.inputText});

  @override
  State<resultsPage> createState() => resultsPageState();
}

class resultsPageState extends State<resultsPage> {
  final _future = Supabase.instance.client
      .from('Recipes')
      .select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
                            Row(
                                children: [
                                  SizedBox(width: 10),
                                  IconButton(
                                      icon: const Icon(Icons.arrow_back_sharp),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }
                                  ),
                                  Expanded(
                                    child:
                                    Align(
                                        alignment: Alignment.center,
                                        child:
                                        Text.rich(
                                          TextSpan(
                                            text: 'Results for ',
                                            style: TextStyle(fontSize: 40),
                                            children: <TextSpan>[
                                              TextSpan(text: widget.inputText, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 40))
                                            ],
                                          ),
                                        )
                                    )
                                  )
                                ]
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 600,
                              width: 550,
                              child: Expanded(
                                  child: ListView.builder(
                                      itemCount: recipes.length,
                                      itemBuilder: ((context, index){
                                        final recipe = recipes[index];
                                        String title = recipe['title'];
                                        String description = recipe['description'];
                                        List<dynamic> ingredients = recipe['ingredients'];
                                        List<dynamic> steps = recipe['steps'];
                                        int time = recipe['time'];
                                        return summarisedRecipe(title: title, description: description, time: time, ingredients: ingredients, steps: steps);
                                      })
                                  )
                                )
                              )
                          ]
                      )
                  )
          );
        }
      ));
  }

}