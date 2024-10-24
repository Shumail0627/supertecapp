// import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class GetLocation extends GetxController {
  Position? currentLocation;
  RxString office = ''.obs;
  UserPreferences pref = UserPreferences();

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
    } else if (status == PermissionStatus.denied) {
      Utils.toastMessage("Location permission is required for check-in.");
    } else if (status == PermissionStatus.permanentlyDenied) {
      Utils.toastMessage("Location permission is permanently denied.");
      openAppSettings();
    }
  }

  getLocation() async {
    final user = await pref.getUser();
    await checkLocationPermission();
    // var status = await Permission.location.request();
    // if (status == PermissionStatus.granted) {
    currentLocation = await Geolocator.getCurrentPosition();
    double latitude = currentLocation?.latitude ?? 0.00;
    double longitude = currentLocation?.longitude ?? 0.00;
    // log(latitude.toString());
    // log(user.remoteWorking.toString());

    final remote = user.remoteWorking.toString();
    // log(remote);
    if (remote.isNotEmpty) {
      if (remote == "no") {
        if (latitude > 24.878550 &&
            latitude < 24.878550 &&
            longitude > 67.062600 &&
            longitude < 67.063000) {
          office.value = "Rehan Foundation";
        } else if ((latitude > 24.877600 &&
            latitude < 24.877900 &&
            longitude > 67.068500 &&
            longitude < 67.068900)) {
          office.value = "Chainak";
        } else if ((latitude > 24.853000 &&
            latitude < 24.854400 &&
            longitude > 67.772900 &&
            longitude < 67.774100)) {
          office.value = "Digital Literacy School Jungshahi";
        } else if ((latitude > 24.738900 &&
            latitude < 24.739400 &&
            longitude > 69.796000 &&
            longitude < 69.796500)) {
          office.value = "Digital Literacy School Mithi";
        } else if ((latitude > 24.850300 &&
            latitude < 24.851200 &&
            longitude > 67.006300 &&
            longitude < 67.007800)) {
          office.value = "Pakistan Media City, I.I Chundrigar Road, New Chali ";
        } else if ((latitude > 24.862800 &&
            latitude < 24.863300 &&
            longitude > 67.085400 &&
            longitude < 67.086200)) {
          office.value = "Social Media Incubator";
        } else if ((latitude > 24.863000 &&
            latitude < 24.863200 &&
            longitude > 67.085700 &&
            longitude < 67.085920)) {
          office.value = "Rehan Youtube Incubator";
        } else if ((latitude > 24.862800 &&
            latitude < 24.863300 &&
            longitude > 67.085400 &&
            longitude < 67.086200)) {
          office.value = "Rehan Help Centre";
        } else if ((latitude > 24.809100 &&
            latitude < 24.810380 &&
            longitude > 67.155209 &&
            longitude < 67.156900)) {
          office.value = "The City Of Knowledge School";
        } else if ((latitude > 24.877200 &&
            latitude < 24.877750 &&
            longitude > 67.069600 &&
            longitude < 67.070350)) {
          office.value = "Million Coders";
        } else if ((latitude > 24.809100 &&
            latitude < 24.810380 &&
            longitude > 67.155209 &&
            longitude < 67.156900)) {
          office.value = "Rehan School Korangi ";
        } else if ((latitude > 24.877200 &&
            latitude < 24.877750 &&
            longitude > 67.069600 &&
            longitude < 67.070350)) {
          office.value = "DIDx";
        } else {
          Utils.toastMessage('Remote check-in is not allowed by admin');
        }
      } else if (remote == "yes") {
        if (latitude > 24.878550 &&
            latitude < 24.878550 &&
            longitude > 67.062600 &&
            longitude < 67.063000) {
          office.value = "Rehan Foundation";
        } else if ((latitude > 24.877600 &&
            latitude < 24.877900 &&
            longitude > 67.068500 &&
            longitude < 67.068900)) {
          office.value = "Chainak";
        } else if ((latitude > 24.853000 &&
            latitude < 24.854400 &&
            longitude > 67.772900 &&
            longitude < 67.774100)) {
          office.value = "Digital Literacy School Jungshahi";
        } else if ((latitude > 24.738900 &&
            latitude < 24.739400 &&
            longitude > 69.796000 &&
            longitude < 69.796500)) {
          office.value = "Digital Literacy School Mithi";
        } else if ((latitude > 24.850300 &&
            latitude < 24.851200 &&
            longitude > 67.006300 &&
            longitude < 67.007800)) {
          office.value = "Pakistan Media City, I.I Chundrigar Road, New Chali ";
        } else if ((latitude > 24.862800 &&
            latitude < 24.863300 &&
            longitude > 67.085400 &&
            longitude < 67.086200)) {
          office.value = "Rehan Help Centre";
        } else if ((latitude > 24.863000 &&
            latitude < 24.863200 &&
            longitude > 67.085700 &&
            longitude < 67.085920)) {
          office.value = "Rehan Youtube Incubator";
        } else if ((latitude > 24.862800 &&
            latitude < 24.863300 &&
            longitude > 67.085400 &&
            longitude < 67.086200)) {
          office.value = "Social Media Incubator";
        } else if ((latitude > 24.809100 &&
            latitude < 24.810380 &&
            longitude > 67.155209 &&
            longitude < 67.156900)) {
          office.value = "The City Of Knowledge School";
        } else if ((latitude > 24.877200 &&
            latitude < 24.877750 &&
            longitude > 67.069600 &&
            longitude < 67.070350)) {
          office.value = "Million Coders";
        } else if ((latitude > 24.809100 &&
            latitude < 24.810380 &&
            longitude > 67.155209 &&
            longitude < 67.156900)) {
          office.value = "Rehan School Korangi ";
        } else if ((latitude > 24.877200 &&
            latitude < 24.877750 &&
            longitude > 67.069600 &&
            longitude < 67.070350)) {
          office.value = "DIDx";
        } else {
          office.value = "remote";
          // Utils.toastMessage('Checkin Working remotely');
        }
      }
    }
  }
}
// }
