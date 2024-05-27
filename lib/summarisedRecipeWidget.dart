import 'package:flutter/material.dart';

class summarisedRecipe extends StatelessWidget {

  String title = '';
  String description = '';
  int time = 0;
  int price = 0;
  int difficulty = 0;
  List ingredients = [];
  List steps = [];

  summarisedRecipe({required this.title, required this.description, required this.time, required this.price, required this.difficulty, required this.ingredients, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title)
            ]
          )
        )
    );
  }

}
