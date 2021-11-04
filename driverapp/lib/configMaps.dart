import 'dart:async';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import './Models/allUsers.dart';
import './Models/drivers.dart';

String mapKey = "AIzaSyCID4FPQwQWf0jdGH_jW1NmD-13noUNJS4";

User firebaseUsers;

Users usersCurrentInfo;

User currentfirebaseuser;

StreamSubscription<Position> hometapPageStreamSubscription;

StreamSubscription<Position> rideStreamSubscription;

// final assetsAudioPlayer = AssetsAudioPlayer.withId("0");

Position currentPos;

Drivers driversInformation;

String title = "there is no rates";

double starCounter = 0.0;

String rideType = "";

// taxi , private car , bike
