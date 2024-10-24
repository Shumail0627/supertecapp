import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/location_model.dart';
import '../../../repository/add_office_repository/add_office_repository.dart';
import '../../../utils/new_all_imports.dart';

class OfficeLocationViewModel extends GetxController {
  OfficeLocationViewModel(this.locationData);
  final LocationPoint locationData;

  final _apiServices = AddOfficeRepository();
  final officeNameController = TextEditingController();
  bool isLoading = false;

  Set<Marker> marker = <Marker>{};
  late CameraPosition cameraPosition;

  void addOfficeLocation(BuildContext context) {
    isLoading = true;
    update();
    log(ModalRoute.of(context)?.isCurrent.toString() ?? '');
    if (locationData.coordinates?.isNotEmpty ?? false) {
      String addOfficeLocation =
          "https://superteclabs.com/apis2/InsertLocation.php?office_name=${officeNameController.text.capitalizeWords().trim()}&latitude=${locationData.coordinates?.first.toString()}&longitude=${locationData.coordinates?.last.toString()}";
      log(addOfficeLocation.toString());

      _apiServices.addOfficeInfoApi(addOfficeLocation).then(
        (value) {
          if (!value['error']) {
            Utils.snackBar('success', value['message']);
            // ignore: use_build_context_synchronously
            if (ModalRoute.of(context)?.isCurrent ?? false) {
              Get.close(2);
            }
          } else {
            log(value['message']);
            Utils.snackBar('error', value['message']);
            isLoading = false;
            update();
          }
        },
      ).onError(
        (error, stackTrace) {
          log(name: 'onError', error.toString());
          isLoading = false;
          update();
        },
      );
    } else {
      Utils.snackBar('Error', "Go back and set Location again");
      isLoading = false;
      update();
    }
  }

  void addMarker() {
    marker.add(Marker(
      markerId: const MarkerId('office'),
      position: LatLng(locationData.coordinates?.first.toDouble() ?? 0.00,
          locationData.coordinates?.last.toDouble() ?? 0.00),
    ));
  }

  @override
  void onInit() {
    super.onInit();
    addMarker();
    cameraPosition = CameraPosition(
      target: LatLng(locationData.coordinates?.first.toDouble() ?? 0.00,
          locationData.coordinates?.last.toDouble() ?? 0.00),
      zoom: 15.0,
    );
  }
}
