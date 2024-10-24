// import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

import '../location/location_handle_model.dart';

class LiveLocationModel extends GetxController {
  final locationPermissionVM = Get.put(GetLocation());
  final fr = FirebaseFirestore.instance;

  RxList<FirebaseLocationModel> locationAllEmployees =
      <FirebaseLocationModel>[].obs;

  String formattedTime = DateFormat('h:mma').format(DateTime.now());
  String formattedDate = DateFormat('dd/MMM').format(DateTime.now());
  final notificationVM = Get.put(NotificationViewModel());

  setLiveLocation(BuildContext context, String userId) async {
    await locationPermissionVM.checkLocationPermission();
    Position currentLocation = await Geolocator.getCurrentPosition();
    double latitude = currentLocation.latitude;
    double longitude = currentLocation.longitude;

    if (latitude != 0 && longitude != 0) {
      await notificationVM.getToken();
      FirebaseLocationModel data = FirebaseLocationModel(
          userId: userId,
          latitude: latitude.toString(),
          longtitude: longitude.toString(),
          time: "$formattedTime $formattedDate",
          notifToken: notificationVM.notiToken.value);

      try {
        fr.collection('Location').doc(userId).set(data.toJson());
      } catch (e) {
        // Utils.toastMessage(e.toString());
      }
    }
  }

  getLiveLocation() async {
    try {
      var querySnapshot = await fr.collection('Location').get();

      locationAllEmployees.clear();

      for (var document in querySnapshot.docs) {
        var data = document.data();
        var firebaseLocationModel = FirebaseLocationModel.fromJson(data);
        locationAllEmployees.add(firebaseLocationModel);
        // log(data.toString());
        // log(locationAllEmployees[0].latitude.toString());
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
    }
  }
}
