import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fullRecipeWidget.dart';
import 'summarisedRecipeWidget.dart';

class listOfSummarisedRecipes extends StatelessWidget {
  List<Map<String, dynamic>> listOfRecipes = [];

  listOfSummarisedRecipes({required this.listOfRecipes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listOfRecipes.length,
        itemBuilder: ((context, index){
          final recipe = listOfRecipes[index];
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
    );
  }
}