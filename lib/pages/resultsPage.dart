import 'package:flutter/material.dart';
import 'package:recipe_thing/dbFunctions.dart';
import 'searchPage.dart';
import '../widgets/summarisedRecipeWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/helpWidget.dart';
import '../widgets/listOfSummarisedRecipesWidget.dart';
import '../dbFunctions.dart';
import 'favouritesPage.dart';
import '../widgets/logOutBttn.dart';

enum orderByOptionsList { TimeAsc, TimeDesc, IngredientsAsc, IngredientsDesc, StepsAsc, StepsDesc}

class resultsPage extends StatefulWidget {
  String inputText = '';
  filterOptions? chosenFilter;

  resultsPage({required this.inputText, required this.chosenFilter});

  @override
  State<resultsPage> createState() => resultsPageState();
}

class resultsPageState extends State<resultsPage> {
  final User? user = Supabase.instance.client.auth.currentUser;

  orderByOptionsList? selectedItem;

  List<Map<String, dynamic>> sortRecipes(List<Map<String, dynamic>> recipes, orderByOptionsList? chosenOrderBy){
    List<Map<String, dynamic>> sortedRecipes = recipes;

    if(selectedItem == orderByOptionsList.TimeAsc){
      sortedRecipes.sort((a,b) => a['time'].compareTo(b['time']));
    }
    else if(selectedItem == orderByOptionsList.TimeDesc){
      sortedRecipes.sort((a,b) => b['time'].compareTo(a['time']));
    }
    if(selectedItem == orderByOptionsList.IngredientsAsc){
      sortedRecipes.sort((a,b) => a['ingredients'].length.compareTo(b['ingredients'].length));
    }
    else if(selectedItem == orderByOptionsList.IngredientsDesc){
      sortedRecipes.sort((a,b) => b['ingredients'].length.compareTo(a['ingredients'].length));
    }
    if(selectedItem == orderByOptionsList.StepsAsc){
      sortedRecipes.sort((a,b) => a['steps'].length.compareTo(b['steps'].length));
    }
    else if(selectedItem == orderByOptionsList.StepsDesc){
      sortedRecipes.sort((a,b) => b['steps'].length.compareTo(a['steps'].length));
    }

    return sortedRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Recipes using ',
                    style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 40)),
                    children: <TextSpan>[
                      TextSpan(text: widget.inputText, style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)))
                    ],
                  ),
                )
            ),
            PopupMenuButton<orderByOptionsList>(
                    initialValue: selectedItem,
                    onSelected: (orderByOptionsList item) {
                      setState((){
                        selectedItem = item;
                      });
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<orderByOptionsList>>[
                      PopupMenuItem<orderByOptionsList>(
                          value: orderByOptionsList.TimeAsc,
                          child: Text('Time (ascending)', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                      ),
                      PopupMenuItem<orderByOptionsList>(
                          value: orderByOptionsList.TimeDesc,
                          child: Text('Time (descending)', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                      ),
                      PopupMenuItem<orderByOptionsList>(
                          value: orderByOptionsList.IngredientsAsc,
                          child: Text('Ingredients (ascending)', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                      ),
                      PopupMenuItem<orderByOptionsList>(
                          value: orderByOptionsList.IngredientsDesc,
                          child: Text('Ingredients (descending)', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                      ),
                      PopupMenuItem<orderByOptionsList>(
                          value: orderByOptionsList.StepsAsc,
                          child: Text('Steps (ascending)', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                      ),
                      PopupMenuItem<orderByOptionsList>(
                          value: orderByOptionsList.StepsDesc,
                          child: Text('Steps (descending)', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                      )
                    ],
                    icon: Icon(Icons.arrow_drop_down)
                )
          ]
        ),
        actions: <Widget>[
          FutureBuilder<bool>(
            future: isUserLoggedIn(),
            builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data == true) {
              return IconButton(
                  icon: Icon(Icons.star_border_outlined),
                  onPressed: () async {
                    final User? user = Supabase.instance.client.auth.currentUser;
                    List favourites = await retrieveUserFavourites(user!.id);
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => favouritesPage(recipeIds: favourites))
                    );
                  }
              );
            }
            else{
              return SizedBox();
            }
            }
          ),
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
      body: Column(
        children: [
          FutureBuilder(
              future: getIngredientId(widget.inputText),
              builder: (context, snapshot) {
                if (!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }
                final ingredientIdAsList = snapshot.data!;
                final ingredientId = ingredientIdAsList[0]['id'].toString();
                if(widget.chosenFilter == null)
                  return FutureBuilder(
                    future: fetchSpecificRecipesByIngredients(ingredientId),
                    builder: (context, snapshotRecipes){
                      if (snapshotRecipes.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshotRecipes.hasError) {
                        return Center(child: Text('Error: ${snapshotRecipes.error}'));
                      }

                      if (snapshotRecipes.data == null) {
                        return Center(child: Text('No recipes found'));
                      }
                      final recipes = snapshotRecipes.data!;
                      final sortedRecipes = sortRecipes(recipes, selectedItem);
                      return SingleChildScrollView(
                          child: Center(
                              child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                        height: 530,
                                        width: 550,
                                        child: listOfSummarisedRecipes(listOfRecipes: sortedRecipes, bgColor: Color(0xFF8CBCB9))
                                    )
                                  ]
                              )
                          )
                      );
                    }
                );
                else {
                  return FutureBuilder(
                      future: fetchSpecificRecipesByIngredients(ingredientId),
                      builder: (context, snapshotRecipes) {
                        if (snapshotRecipes.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshotRecipes.hasError) {
                          return Center(child: Text('Error: ${snapshotRecipes
                              .error}'));
                        }

                        if (snapshotRecipes.data == null) {
                          return Center(child: Text('No recipes found'));
                        }
                        final recipes = snapshotRecipes.data!;

                        int foodTypeToRemove = 0;
                        if(widget.chosenFilter == filterOptions.Fruit){
                          foodTypeToRemove = 1;
                        }
                        else if(widget.chosenFilter == filterOptions.Veg){
                          foodTypeToRemove = 2;
                        }
                        else if(widget.chosenFilter == filterOptions.Spices){
                          foodTypeToRemove = 3;
                        }
                        else if(widget.chosenFilter == filterOptions.Grains){
                          foodTypeToRemove = 4;
                        }
                        else if(widget.chosenFilter == filterOptions.OilsAndSauces){
                          foodTypeToRemove = 5;
                        }
                        else if(widget.chosenFilter == filterOptions.Dairy){
                          foodTypeToRemove = 6;
                        }
                        else if(widget.chosenFilter == filterOptions.Meat){
                          foodTypeToRemove = 7;
                        }
                        else if(widget.chosenFilter == filterOptions.Seafood){
                          foodTypeToRemove = 8;
                        }
                        else if(widget.chosenFilter == filterOptions.CupboardStaples){
                          foodTypeToRemove = 9;
                        }

                        return FutureBuilder(
                          future: getListOfIngredientsWithSpecificFoodType(foodTypeToRemove),
                          builder: (context, snapshotFilters){
                            if (snapshotFilters.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshotFilters.hasError) {
                              return Center(child: Text('Error: ${snapshotRecipes
                                  .error}'));
                            }
                            if (snapshotFilters.data == null) {
                              return Center(child: Text('No recipes found'));
                            }

                            final listOfIngredientsToRemove = snapshotFilters.data;
                            final finalListOfIngredientsToRemove = [];
                            for(int i=0;i<listOfIngredientsToRemove!.length;i++){
                              finalListOfIngredientsToRemove.add(listOfIngredientsToRemove[i]['id']);
                            }
                            final recipes1 = fetchSpecificRecipesByIngredientsWithFilter(recipes, finalListOfIngredientsToRemove);
                            final sortedRecipes = sortRecipes(recipes1, selectedItem);
                            return SingleChildScrollView(
                                child: Center(
                                    child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                              height: 530,
                                              width: 550,
                                              child: listOfSummarisedRecipes(
                                                  listOfRecipes: sortedRecipes,
                                                  bgColor: Color(0xFF8CBCB9))
                                          )
                                        ]
                                    )
                                )
                            );
                        }
                        );
                      }
                  );
                };
              }
          ),
          FutureBuilder<bool>(
            future: isUserLoggedIn(),
            builder: (context, snapshot){
              if (snapshot.hasData && snapshot.data == true){
                return Column(
                  children: [
                    SizedBox(height: 10),
                    logOutButton()
                  ]
                );
              }
              else{
                return SizedBox();
              }
            }
          )
        ]
      )
    );
  }

}