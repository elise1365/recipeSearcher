import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class helpCard extends StatelessWidget {

  helpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 700,
            height: 200,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                  child: Column(
                      children: [
                        Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }),
                              SizedBox(width: 10),
                              Text(
                                'Help',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                              )
                            ]
                        ),
                        SizedBox(height: 25),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                  text:
                                        TextSpan(
                                            text: 'Report any issues/ feature requests/ questions',
                                            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 18),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                launch('https://forms.gle/WNgnebYdLPPvQqRTA');
                                              }
                                        )
                                  )
                            ]
                        ),
                        SizedBox(height: 25),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                      text: 'Github',
                                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 18),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          launch('https://github.com/elise1365');
                                        }
                                    )
                                )
                            ]
                        )
                      ]
                  )
              )
            )
          )
        )
      ],
    );
  }
}