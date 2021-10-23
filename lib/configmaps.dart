// import '../Models/allUsers.dart';
// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxsibul/Models/allUsers.dart';

String mapKey = "AIzaSyCID4FPQwQWf0jdGH_jW1NmD-13noUNJS4";
String serverToken =
    "key=AAAA9-xQe4E:APA91bHzYSOoFREXrwXlMVZymhdH3K-DmNAxmn8Vq-srwsGE1Dbl_LauBaWk-6fH-TfiVIEr7ZUxitnJQmfJnQZhT97JxwuZRW7BXfbhmxPQGFQbHaczODAmqUvdI7IaUmyQw2yU87Cj";
User firebaseUsers;
Users usersCurrentInfo;
int driverRequistTimeOnt = 40;
String statusRide = "";
String carDetailsDriver = "";
String driverName = "";
String driverPhone = "";
String rideStatus = "on the way";
double starCounter = 0.0;
String title = "";
String carRideType = "";
