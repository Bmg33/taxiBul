// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxsibul/Assistants/assistantMethods.dart';
import 'package:taxsibul/DataHandler/appData.dart';
import 'package:taxsibul/Screens/searchScreen.dart';

import '../AllWidgets/progressDialog.dart';

import '../Screens/loginScreen.dart';
import '../Screens/myHistory.dart';
import '../Screens/profileScreen.dart';

import '../myColors/MyColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String screenId = "mainScrreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Completer<GoogleMapController> _controllergoogleMap = Completer();
GoogleMapController newGooglemapController;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.015137, 28.979530), // istanbul
    zoom: 14.4746,
  );
  bool nearByAvailableDriverskeysLoaded = false;
  Position currentPosition;
  var geolocator = Geolocator();
  void locateposition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGooglemapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("this is your Address :: " + address);

    // uName = "${usersCurrentInfo.name} ${usersCurrentInfo.surname}";

    // initGeoFireListener();
  }

  // Start ...
  @override
  String uName = "";

  GlobalKey<ScaffoldState> scafuldKey = new GlobalKey<ScaffoldState>();

  bool isTheAnyImge = false;
  double bottumpaddingofMap = 0;

  bool drwoerOpen = true;

  double searchContainerHeight = 300.0;
  double rideDetailsContainerHeight = 0;
  double requistRideDetailsContainerHeight = 0;
  double driverDetailsContainerHeight = 0;

  @override
  Widget build(BuildContext context) {
    // creatIconMarker();
    return Scaffold(
      key: scafuldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: MyColors.asfar_color),
        backgroundColor: MyColors.petroly_color,
        centerTitle: true,
        title: Text(
          "Map",
          style: TextStyle(color: MyColors.asfar_color),
        ),
      ),
      drawer: Container(
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //drower header
              Container(
                child: DrawerHeader(
                  decoration: BoxDecoration(color: MyColors.petroly_color),
                  child: Row(
                    children: [
                      Image.asset('images/user_icon.png',
                          height: 65.0, width: 65.0),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              uName,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Brand-bold",
                                  color: MyColors.asfar_color),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //drawer header end ...
              Divider(
                height: 1.0,
                color: Colors.white30,
                thickness: 1.0,
              ),
              SizedBox(height: 12.0),
              //draweer body
              GestureDetector(
                onTap: () {
                  // AsisstentMethods.retrieveHistoryInfo(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HestoryScreen()),
                  // );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.history,
                    color: MyColors.asfar_color,
                  ),
                  title: Text("History",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.screenId);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: MyColors.asfar_color,
                  ),
                  title: Text("profile Screen",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  //  Navigator.pushNamed(context, AboutScreen.screenId);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: MyColors.asfar_color,
                  ),
                  title: Text("About",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      )),
                ),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.screenid, (route) => false);
                },
                leading: Icon(
                  Icons.exit_to_app,
                  color: MyColors.asfar_color,
                ),
                title: Text("Sign Out",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    )),
              ),
              //draweer body End....
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottumpaddingofMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            // polylines: polylineSet,
            // markers: markersSet,
            // circles: circlesSet,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllergoogleMap.complete(controller);
              newGooglemapController = controller;
              setState(() {
                bottumpaddingofMap = 350.0;
              });

              locateposition();
            },
          ),
          // // Hamburger btn . . .
          Positioned(
            top: 38.0,
            left: 22.0,
            child: GestureDetector(
              // onTap: () {
              //   //display drawer ..

              //   if (drwoerOpen) {
              //     scafuldKey.currentState.openDrawer();
              //   } else {
              //     cancleRequist();
              //     resetApp();
              //   }
              // },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      )
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    (drwoerOpen) ? Icons.menu : Icons.close,
                    color: Colors.black,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),

          // Search Container  ui
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: searchContainerHeight,
              decoration: BoxDecoration(
                  color: MyColors.petroly_color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.0),
                    SizedBox(height: 24.0),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: MyColors.asfar_color,
                          size: 35,
                        ),
                        SizedBox(width: 12.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "your location :",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Provider.of<AppData>(context).pickUpLocation !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .pickUpLocation
                                        .placeName
                                    : "",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    // DividerWidget(),
                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () async {
                        if (Provider.of<AppData>(context, listen: false)
                                .pickUpLocation
                                .placeName ==
                            null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ));
                        if (res == "obtainDirection") {
                          // displayRideDetailsContainer();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.asfar_color,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              )
                            ]),
                        child: Container(
                          height: 60.0,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "where to go ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.petroly_color),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // car requist Container UI
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainerHeight,
                decoration: BoxDecoration(
                    color: MyColors.petroly_color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      SizedBox(height: 35),
                      GestureDetector(
                        onTap: () {
                          // displayToastMsg("يتم البحث عن ديليفري جديد", context);
                          // setState(() {
                          //   state = "requisting";
                          //   carRideType = "bike";
                          // });
                          // displayRequistHeightContainer();
                          // availableDrievrs =
                          //     GeoFireAssistent.nearbyAvailableDraiversList;
                          // searchNearistDriver();
                        },
                        child: Container(
                          width: double.infinity,
                          color: MyColors.asfar_color,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //
                                Image.asset("images/car_android.png",
                                    height: 70.0, width: 90.0),
                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "delevery",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Divider(height: 2.0, thickness: 2.0),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          color: MyColors.asfar_color,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                //
                                Image.asset("images/car_android.png",
                                    height: 70.0, width: 90.0),
                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Taxi",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Divider(height: 2.0, thickness: 2.0),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          color: MyColors.asfar_color,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                //
                                Image.asset("images/car_android.png",
                                    height: 70.0, width: 90.0),
                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "private car",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Divider(height: 2.0, thickness: 2.0),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            SizedBox(width: 16.0),
                            Text(
                              "cash",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 6.0),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // cancel requist..
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: requistRideDetailsContainerHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  color: MyColors.petroly_color,
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 16.0,
                      color: Colors.black54,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Finding a Driver'),
                            WavyAnimatedText('please wait ...'),
                          ],
                          isRepeatingAnimation: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "cancle ride",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void displayToastMsg(String msg, BuildContext cxt) {
    Fluttertoast.showToast(msg: msg, textColor: Colors.green);
  }
}

void goToHisstor(BuildContext context) {
  Navigator.pushNamed(context, MyHistory.screenId);
}
