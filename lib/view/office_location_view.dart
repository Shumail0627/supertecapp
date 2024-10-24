import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:supertec_app_clean_code/res/colors/app_colors.dart';
import 'package:supertec_app_clean_code/res/components/custom_text.dart';
import 'package:supertec_app_clean_code/view/google_map/google_map_view.dart';

import '../models/office_locations_model.dart';
import '../repository/add_office_repository/add_office_repository.dart';
import '../utils/utils.dart';

class AllOfficeLocationView extends StatefulWidget {
  const AllOfficeLocationView({super.key});

  @override
  State<AllOfficeLocationView> createState() => AllOfficeLocationViewState();
}

class AllOfficeLocationViewState extends State<AllOfficeLocationView> {
  final _apiservices = AddOfficeRepository();
  bool isLoading = false;

  final List<OfficeLocationModel> officeLocations = [];

  void setLoader(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void getOfficeLocation() {
    setLoader(true);
    _apiservices.getOfficeLocations().then(
      (value) async {
        if (!value['error']) {
          if (value['data'] != null && value['data'].isNotEmpty) {
            for (var i in value['data']) {
              // Convert to OfficeLocationModel
              OfficeLocationModel officeLocation =
                  OfficeLocationModel.fromMap(i);

              // Fetch the address based on coordinates
              final coordinates = Coordinates(
                double.tryParse(officeLocation.latitude ?? '') ?? 0.00,
                double.tryParse(officeLocation.longitude ?? '') ?? 0.00,
              );
              List<Address> placemarks = await Geocoder.local
                  .findAddressesFromCoordinates(coordinates);

              // Update the address in the model
              officeLocation.address = placemarks.isNotEmpty
                  ? placemarks.first.addressLine
                  : 'Address not found';

              // Add to the list
              officeLocations.add(officeLocation);
            }
            setLoader(false);
            Utils.snackBar('success', value['message']);
          }
        } else {
          setLoader(false);
          Utils.snackBar('error', value['message']);
        }
      },
    ).onError(
      (error, stackTrace) {
        setLoader(false);
        log(error.toString());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getOfficeLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.darkBlue,
        title: const TextComponent(
          text: "Office Locations",
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: officeLocations.length,
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.work),
                      title: TextComponent(
                          text: officeLocations[index].officeName ?? ''),
                      subtitle: TextComponent(
                          text: officeLocations[index].address ??
                              'Fetching address...'),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => GoogleMapView(
                                  lat: officeLocations[index].latitude,
                                  long: officeLocations[index].longitude,
                                ));
                          },
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          )),
                    ),
                  )),
    );
  }
}
