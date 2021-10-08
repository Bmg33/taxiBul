import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../allwidgets/CustomColors.dart';
import '../dataHandler/appData.dart';

class HestoryScreen extends StatefulWidget {
  @override
  _HestoryScreenState createState() => _HestoryScreenState();
}

class _HestoryScreenState extends State<HestoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CostumColors.petroly_color,
      ),
    );
  }
}
