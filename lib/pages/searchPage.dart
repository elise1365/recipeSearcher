import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'resultsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/helpWidget.dart';
import 'signUpPage.dart';
import 'signInPage.dart';
import '../dbFunctions.dart';
import 'favouritesPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/logOutBttn.dart';

enum filterOptions { Fruit, Veg, Dairy, Seafood, Meat, Grains, CupboardStaples, Spices, OilsAndSauces}

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => searchPageState();
}

class searchPageState extends State<searchPage> {
  final User? user = Supabase.instance.client.auth.currentUser;

  final myController = TextEditingController();

  filterOptions? selectedItem;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
            SizedBox(height: 180),
            Text('Welcome to Recipe Searcher', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 40))),
            Text('Enter an ingredient and hit the search button!', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 20))),
            SizedBox(height: 20),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 145,
                        child: Row(
                            children: [
                              Text('Filter recipes', style: GoogleFonts.lexend(fontSize: 16)),
                              PopupMenuButton<filterOptions>(
                                  initialValue: selectedItem,
                                  onSelected: (filterOptions item) {
                                    setState((){
                                      selectedItem = item;
                                    });
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<filterOptions>>[
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.CupboardStaples,
                                        child: Text('Cupboard staples', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.Dairy,
                                        child: Text('Dairy', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.Fruit,
                                        child: Text('Fruit', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.Grains,
                                        child: Text('Grains', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.Meat,
                                        child: Text('Meat', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.OilsAndSauces,
                                        child: Text('Oils and sauces', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.Seafood,
                                        child: Text('Seafood', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.Spices,
                                        child: Text('Spices', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    ),
                                    PopupMenuItem<filterOptions>(
                                        value: filterOptions.Veg,
                                        child: Text('Veg', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: 12)))
                                    )
                                  ],
                                  icon: Icon(Icons.arrow_drop_down)
                              )
                            ]
                        )
                    ),
                    SizedBox(
                          width: 250,
                          child: TextField(
                              controller: myController,
                              style: GoogleFonts.lexend(textStyle: TextStyle()),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8997D1))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Color(0xFF8997D1))),
                                  hintText: 'Start typing...',
                                  filled: true,
                                  fillColor: Color(0xFF8997D1)
                              )
                          )
                    ),
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  resultsPage(inputText: myController.text, chosenFilter: selectedItem))
                          );
                        }
                    ),
                  ]
              ),
            SizedBox(height: 20),
            FutureBuilder<bool>(
                future: isUserLoggedIn(),
                builder: (context, snapshot){
                  if (snapshot.hasData && snapshot.data == true){
                    return Column(
                        children: [
                          SizedBox(height: 210),
                          logOutButton()
                        ]
                    );
                  }
                  else{
                    return Column(
                      children: [
                        RichText(
                          text:
                          TextSpan(
                              text: 'Create an account ',
                              style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          signUp())
                                  );
                                },
                              children:[
                                TextSpan(
                                    text: 'to favourite recipes',
                                    style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 20))
                                )
                              ]
                          ),
                        ),
                        RichText(
                          text:
                          TextSpan(
                            text: 'Sign in',
                            style: GoogleFonts.lexend(textStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        signIn())
                                );
                              },
                          ),
                        )
                      ]
                    );
                  }
                }
            )
          ],
      ),
    );
  }
}