// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:taxsibul/Models/address.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation, dropOffLocation;
  void updatePickUpLocationAddress(Address pickupAddrss) {
    pickUpLocation = pickupAddrss;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropoffAddress) {
    dropOffLocation = dropoffAddress;
    notifyListeners();
  }
}
