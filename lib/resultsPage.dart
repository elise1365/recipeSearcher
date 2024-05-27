import 'package:flutter/material.dart';
import 'searchPage.dart';
import 'summarisedRecipeWidget.dart';

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
                        ),
                        summarisedRecipe(title: 'hello', description: 'asdfbn', time: 30, price: 1, difficulty: 2, ingredients: ['bread'], steps: ['stp', 'sdfgh'])
                      ]
                  ),
                ]
            )
        )
      )
    );
  }

}