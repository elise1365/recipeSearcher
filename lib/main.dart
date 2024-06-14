import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/searchPage.dart';
import 'pages/resultsPage.dart';
import 'pages/signInPage.dart';
import 'pages/signUpPage.dart';
import 'pages/favouritesPage.dart';
import '../dbFunctions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase.initialize(
    url: 'https://bthsbmtuuchuqqhghzuh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0aHNibXR1dWNodXFxaGdoenVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTczNDM0MTksImV4cCI6MjAzMjkxOTQxOX0.MTe6l5DHDTrZ5Y7dMhFOdigzhn_g_h0t6e_b0JwahEs',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Searcher',
      debugShowCheckedModeBanner: false,
      // home: favouritesPage(recipeIds: [3,2])
      // home: resultsPage(inputText: 'garlic')
      // home: signIn()
      // home: signUp()
      home: searchPage()
    );
  }
}

