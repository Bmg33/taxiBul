// ignore_for_file: deprecated_member_use, prefer_const_constructors, file_names, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxsibul/Screens/homescreen.dart';
import 'package:taxsibul/configmaps.dart';

class ProfileTabPage extends StatelessWidget {
  static const String screenId = "pscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              usersCurrentInfo.name,
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Brand-bold"),
            ),
            SizedBox(
              height: 20.0,
              width: 200.0,
              child: Divider(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            buildTheCard(usersCurrentInfo.phone, Icons.phone_android),
            Divider(height: 30, thickness: 1.0),
            buildTheCard(usersCurrentInfo.email, Icons.email),
            Divider(height: 30, thickness: 1.0),
            SizedBox(height: 50),
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.screenId, (Route) => false);
              },
              child: const Text(
                'Go Back',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }

  buildTheCard(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            icon,
            size: 25,
          ),
        ),
      ],
    );
  }
}
