import 'package:flutter/material.dart';
import 'searchPage.dart';
import '../widgets/summarisedRecipeWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/helpWidget.dart';
import '../widgets/listOfSummarisedRecipesWidget.dart';

class resultsPage extends StatefulWidget {
  String inputText = '';

  resultsPage({required this.inputText});

  @override
  State<resultsPage> createState() => resultsPageState();
}

class resultsPageState extends State<resultsPage> {

  @override

  Widget build(BuildContext context) {
    String _inputText = widget.inputText;
    final _future = Supabase.instance.client
        .from('Recipes')
        .select()
        .contains('ingredients', [_inputText]);

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
                              height: 600,
                              width: 550,
                              child: Expanded(
                                  child: listOfSummarisedRecipes(listOfRecipes: recipes)
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