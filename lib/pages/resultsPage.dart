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

class resultsPage extends StatefulWidget {
  String inputText = '';

  resultsPage({required this.inputText});

  @override
  State<resultsPage> createState() => resultsPageState();
}

class resultsPageState extends State<resultsPage> {
  final User? user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
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
      body: FutureBuilder(
        future: fetchSpecificRecipesByIngredients(widget.inputText),
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
                              height: 600,
                              width: 550,
                              child: listOfSummarisedRecipes(listOfRecipes: recipes, bgColor: Color(0xFF8CBCB9))
                              )
                          ]
                      )
                  )
          );
        }
      ));
  }

}