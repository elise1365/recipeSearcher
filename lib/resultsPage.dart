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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Center(
                  child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.arrow_back_sharp),
                                  tooltip: 'Back to search',
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }
                              ),
                              SizedBox(width: 450),
                              Text.rich(
                                TextSpan(
                                  text: 'Results for ',
                                  style: TextStyle(fontSize: 40),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.inputText, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 40))
                                  ],
                                ),
                              )
                            ]
                        ),
                        Row(children: [SizedBox(height: 20)]),
                        Column(
                            children: [
                              summarisedRecipe(title: 'Carbonara', description: 'asdfbn', time: 30, ingredients: ['bread'], steps: ['stp']),
                              summarisedRecipe(title: 'Egg fried rice', description: 'asdfbnsdfgtyuioiuygfghioiuasdfghjkljhugytfrertyuiopiuytrewrtghjmnbvcdfrtyujhmnbvgfdrtyuijkmhngbfrtyujkhmnhgfvghg', time: 30, ingredients: ['bread', 'apples'], steps: ['stp', 'sdfgh']),
                              summarisedRecipe(title: 'Chilli con carne', description: 'asdfbn', time: 30, ingredients: ['bread', 'banana', ' avocadao'], steps: ['r4567uijkhngbojinbur4567uijkhngbfder456u7yjhnbvcxdser45ty6hbvtr yvubiojinbuvyctvuibh9j09biu y', 'sdfgh', 'stp', 'sdfgh', 'stp', 'sdfgh', 'stp', 'sdfgh']),
                              summarisedRecipe(title: 'Toast', description: 'asdfbn', time: 30, ingredients: ['bread'], steps: ['stp', 'sdfgh']),
                              summarisedRecipe(title: 'Sausages and mash', description: 'asdfbn', time: 30, ingredients: ['bread'], steps: ['stp', 'sdfgh'])

                            ]
                        )
                      ]
                  )
              )
    ));
  }

}