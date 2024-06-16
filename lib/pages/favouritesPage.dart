import 'searchPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/helpWidget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/listOfSummarisedRecipesWidget.dart';
import 'package:flutter/gestures.dart';
import '../dbFunctions.dart';

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
                List<Map<String, dynamic>> selectedRecipes = fetchSpecificRecipesByIds(widget.recipeIds, recipes) as List<Map<String, dynamic>>;

                return
                  SingleChildScrollView(
                      child: Center(
                          child: Column(
                              children: [
                                SizedBox(height: 20),
                                    Container(
                                      height: 530,
                                        width: 550,
                                        child: listOfSummarisedRecipes(listOfRecipes: selectedRecipes, bgColor: Color(0xFFC27684))
                                    )
                              ]
                          )
                      )
                  );
              }
          ),
          SizedBox(height: 15),
          Row(
              children: [
                SizedBox(width: 500),
                RichText(
                    text: TextSpan(
                        text: 'Return to search',
                        style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 20, color: Colors.blue, decoration: TextDecoration.underline)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => searchPage())
                            );
                          },
                        children:[
                          TextSpan(
                              text: ' or ',
                              style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none))
                          ),
                          TextSpan(
                            text: 'Sign out',
                            style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 20, color: Colors.blue, decoration: TextDecoration.underline)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                Supabase.instance.client.auth.signOut();
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => searchPage())
                                );
                              }
                          )
                        ]
                        )
                    )
                  ]
              )
          ]
        )
      )
    );
  }
}