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

Future<void> retrieveUserFavourites(int userID) async {
  final favourites = await Supabase.instance.client
      .from('Users')
      .select();

  print(favourites);
}