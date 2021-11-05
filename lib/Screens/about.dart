// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use, unnecessary_new, use_key_in_widget_constructors

import "package:flutter/material.dart";
import 'package:taxsibul/Screens/homescreen.dart';

class AboutScereen extends StatefulWidget {
  static const String screenid = "aboutscreen";
  @override
  _AboutScereenState createState() => _AboutScereenState();
}

class _AboutScereenState extends State<AboutScereen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: 220,
            child: Center(
              child: Image.asset('images/taxix.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 24, right: 24),
            child: Column(
              children: [
                Text(
                  'TaxiBul',
                  style: TextStyle(fontSize: 90, fontFamily: 'Signatra'),
                ),
                SizedBox(height: 30),
                Text(
                  'TaxiBul is a transportation company with an app that allows passengers to hail a ride and drivers to charge fares and get paid. More specifically, TaxiBul is a ridesharing company that hires independent contractors as drivers.',
                  style: TextStyle(fontFamily: "Brand Bold"),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          FlatButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.screenId, (Route) => false);
            },
            child: const Text(
              'Go Back',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
