import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_thing/dbFunctions.dart';
import 'fullRecipeWidget.dart';
import 'summarisedRecipeWidget.dart';

class listOfSummarisedRecipes extends StatelessWidget {
  List<Map<String, dynamic>> listOfRecipes = [];
  Color bgColor = Colors.white;

  listOfSummarisedRecipes({required this.listOfRecipes, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listOfRecipes.length,
        itemBuilder: ((context, index){
          final recipe = listOfRecipes[index];
          int id = recipe['id'];
          String title = recipe['title'];
          String description = recipe['description'];
          List<dynamic> ingredients = recipe['ingredients'];
          List<dynamic> steps = recipe['steps'];
          int time = recipe['time'];

          Future<List<String>> fetchIngredientNames(List<dynamic> ingredientIds) async{
            List<String> ingredientNames = [];
            for(int i=0;i<ingredients.length;i++){
              String ingredientName = await getIngredientNameFromId(ingredients[i]);
              ingredientNames.add(ingredientName);
            }
            // print(ingredientNames);
            return ingredientNames;
          }

          return FutureBuilder<List<String>>(
            future: fetchIngredientNames(ingredients),
            builder: (context, snapshot){
              List<String> ingredientNames = snapshot.data ?? [];
              return summarisedRecipe(
                  title: title,
                  description: description,
                  time: time,
                  ingredients: ingredientNames,
                  steps: steps,
                  id: id,
                  bgColor: bgColor);
            }
          );
        })
    );
  }
}