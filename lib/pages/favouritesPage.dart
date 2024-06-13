import 'searchPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/helpWidget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/summarisedRecipeWidget.dart';
import '../widgets/listOfSummarisedRecipesWidget.dart';

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
        title: Column(children: [SizedBox(height: 15), Center(child: Text('Favourite recipes', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 40))))]),
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
                List<Map<String, dynamic>> selectedRecipes = [];

                for(int i=0;i<recipes.length;i++){
                  for (int y=0;y<widget.recipeIds.length;y++){
                    final recipe = recipes[i];
                    if(recipe['id'] == widget.recipeIds[y]){
                      selectedRecipes.add(recipe);
                    }
                  }
                }

                return
                  SingleChildScrollView(
                      child: Center(
                          child: Column(
                              children: [
                                SizedBox(height: 20),
                                    Container(
                                      height: 580,
                                        width: 550,
                                        child: listOfSummarisedRecipes(listOfRecipes: selectedRecipes)
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