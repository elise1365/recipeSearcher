import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_thing/pages/favouritesPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.initialize(
  url: 'https://bthsbmtuuchuqqhghzuh.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0aHNibXR1dWNodXFxaGdoenVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTczNDM0MTksImV4cCI6MjAzMjkxOTQxOX0.MTe6l5DHDTrZ5Y7dMhFOdigzhn_g_h0t6e_b0JwahEs',
);

Future<List<Map<String, dynamic>>> fetchAllRecipes() async {
  final allRecipes = await Supabase.instance.client
      .from('Recipes')
      .select();

  return allRecipes;
}

Future<List<Map<String, dynamic>>> fetchSpecificRecipesByIngredients(String ingredient) async {
  final specificRecipes = Supabase.instance.client
      .from('Recipes')
      .select()
      .contains('ingredients', [ingredient]);

  return specificRecipes;
}

List<Map<String, dynamic>> fetchSpecificRecipesByIngredientsWithFilter(List recipes, List ingredientsToRemove) {
  List<Map<String, dynamic>> filteredRecipeList = [];

  for(int i=0;i<recipes.length;i++){
    bool shouldRemove = false;
    for(int y=0;y<recipes[i]['ingredients'].length;y++){
      if(ingredientsToRemove.contains(recipes[i]['ingredients'][y])){
        shouldRemove = true;
        break;
      }
    }
    if(shouldRemove == false){
      filteredRecipeList.add(recipes[i]);
    }
  }

  return filteredRecipeList;
}

Future<List<Map<String, dynamic>>> getListOfIngredientsWithSpecificFoodType(int foodType){
  final ingredientsToRemove = Supabase.instance.client
      .from('Ingredients')
      .select('id')
      .eq('food_type_id', foodType);

  return ingredientsToRemove;
}

Future<List<Map<String, dynamic>>> getIngredientId(String ingredient) async {
  final findIngredientId = Supabase.instance.client
      .from('Ingredients')
      .select('id')
      .eq('ingredient_name', ingredient);

  return findIngredientId;
}

Future<String> getIngredientNameFromId(int id) async{
  final findIngredientName = await Supabase.instance.client
      .from('Ingredients')
      .select('ingredient_name')
      .eq('id', id);

  return findIngredientName[0]['ingredient_name'];
}

List<Map<String, dynamic>> fetchSpecificRecipesByIds(List ids, final allRecipes) {
  List<Map<String, dynamic>> selectedRecipes = [];

  for(int i=0;i<allRecipes.length;i++){
    for (int y=0;y<ids.length;y++){
      final recipe = allRecipes[i];
      if(recipe['id'] == ids[y]){
        selectedRecipes.add(recipe);
      }
    }
  }

  return selectedRecipes;
}

Future<List> retrieveUserFavourites(String userID) async {
  final favourites = await Supabase.instance.client
      .from('Users')
      .select('recipesIDs')
      .eq('userId', userID);

  Map<String, dynamic> favourites1 = favourites[0];

  List recipeIds = [];

  if (favourites1['recipesIDs'] is List) {
    List<dynamic> recipeIds = favourites1['recipesIDs'];

    for (int i = 0; i < recipeIds.length; i++) {
      // print('Index $i: ${recipeIds[i]}');
    }
    // print(recipeIds);
    return recipeIds;

  } else {
    throw Exception('Invalid data format');
  }

}

void addUserToUsersDb(String userID) async {
  final favourites = await Supabase.instance.client
      .from('Users')
      .insert([
        {'userId': userID}
      ]);
}

void addRecipeToUserFavourites(int recipeId) async {
  final User? user = Supabase.instance.client.auth.currentUser;
  // print(user);

  if(user == null){
    print('user not logged in');
  }
  else {
    // get the list of users current favourites
    final currentFavouriteRecipes = await Supabase.instance.client
        .from('Users')
        .select('recipesIDs')
        .eq('userId', user.id);

    Map<String, dynamic> currentFavouriteRecipesMap = currentFavouriteRecipes[0];
    List currentFavouriteRecipesList = currentFavouriteRecipesMap['recipesIDs'];

    // add the recipeId passed to the list
    currentFavouriteRecipesList.add(recipeId);

    // add the edited list to the Users table in the db
    final response = await Supabase.instance.client
        .from('Users')
        .update({'recipesIDs': currentFavouriteRecipesList})
        .eq('userId', user.id);

  }
}

void removeRecipeFromUserFavourites(int recipeId) async {
  final User? user = Supabase.instance.client.auth.currentUser;

  if(user == null){
    print('user not logged in');
  }
  else{
    // get list from users row in Users table
    final currentFavouriteRecipes = await Supabase.instance.client
        .from('Users')
        .select('recipesIDs')
        .eq('userId', user.id);

    Map<String, dynamic> currentFavouriteRecipesMap = currentFavouriteRecipes[0];
    List currentFavouriteRecipesList = currentFavouriteRecipesMap['recipesIDs'];

    // remove recipe from list
    currentFavouriteRecipesList.remove(recipeId);

    // add edited list back to db
    final response = await Supabase.instance.client
        .from('Users')
        .update({'recipesIDs': currentFavouriteRecipesList})
        .eq('userId', user.id);
  }
}

Future<bool> isAlreadyInFavourites(int recipeId) async {
  final User? user = Supabase.instance.client.auth.currentUser;

  if(user == null){
    print('user is not logged in');
    return false;
  }
  else{
    // get list from users row in Users table
    final currentFavouriteRecipes = await Supabase.instance.client
        .from('Users')
        .select('recipesIDs')
        .eq('userId', user.id);

    Map<String, dynamic> currentFavouriteRecipesMap = currentFavouriteRecipes[0];
    List currentFavouriteRecipesList = currentFavouriteRecipesMap['recipesIDs'];

    if (currentFavouriteRecipesList.contains(recipeId)){
      return true;
    }
    else{
      return false;
    }
  }
}

Future<bool> isUserLoggedIn() async{
  final User? user = Supabase.instance.client.auth.currentUser;

  if(user == null){
    return false;
  }
  else{
    return true;
  }
}

Color colourByType(int ingredientType){
  List<Color> listOfColours = [
    Color(0xFFDA5872),
    Color(0xFFF5937A),
    Color(0xFFFFD151),
    Color(0xFF8CBCB9),
    Color(0xFF8997D1),
    Color(0xFFD69EE3),
    Color(0xFF86BA90),
    Color(0xFF53A1F3),
    Color(0xFFF26990)];

  Color colour = listOfColours[ingredientType];
  return colour;
}

Future<List<Map<String, dynamic>>> getIngredientType(String ingredientName) async {
  final ingredientType = Supabase.instance.client
    .from('Ingredients')
    .select('food_type_id')
    .eq('ingredient_name', ingredientName);

  // print(ingredientType);

  return ingredientType;
}
