import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_thing/dbFunctions.dart';
import 'package:supabase/supabase.dart';

class ingredientCard extends StatelessWidget{
  String ingredientName = '';

  ingredientCard({required this.ingredientName});

  @override
  Widget build(BuildContext context){

    Future<List<Map<String, dynamic>>> fetchIngredientNames(String ingredientName) async{
      List<Map<String, dynamic>> ingredientTypeId = await getIngredientType(ingredientName);
      // print(ingredientTypeId);
      return ingredientTypeId;
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchIngredientNames(ingredientName),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if (snapshot.hasError){
            return Text('Error');
          }
          else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Card(
                color: Colors.white,
                elevation: 0,
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(ingredientName, style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16)))
                    )
                )
            );
          }
          else{
            List<Map<String, dynamic>>? ingredientTypeAsList = snapshot.data;
            Map<String, dynamic>? ingredientTypeAsMap = ingredientTypeAsList?[0];
            int ingredientType = ingredientTypeAsMap?['food_type_id'];
            ingredientType -= 1;
            // print(ingredientName);

            return Card(
                color: colourByType(ingredientType),
                elevation: 0,
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(ingredientName, style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 16)))
                    )
                )
            );
          }
        }
    );
  }
}