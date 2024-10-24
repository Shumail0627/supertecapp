import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/location_model.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/custom_text.dart';
import '../../utils/utils.dart';
import 'office_location.dart';

class AddCompanyLocation extends StatefulWidget {
  const AddCompanyLocation({super.key});

  @override
  State<AddCompanyLocation> createState() => _AddCompanyLocationState();
}

class _AddCompanyLocationState extends State<AddCompanyLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _kGooglePlex;
  bool loading = true;
  String currentLocation = "";
  LocationPoint? location;
  @override
  void initState() {
    super.initState();
    getLocation().then((value) {
      debugPrint("CURRENT CORDS:::::::${value.latitude}-${value.longitude}}");
      setState(() {
        _kGooglePlex = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 14.4746,
        );
        onMarkMoving(); // Update location when map is initialized
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColor.darkBlue,
        title: const TextComponent(
          text: 'Add Office Location',
          color: Colors.white,
          fweight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          if (_kGooglePlex != null)
            GoogleMap(
              initialCameraPosition: _kGooglePlex!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              zoomControlsEnabled: false,
              onCameraIdle:
                  onMarkMoving, // Update location when map stops moving
              onCameraMove: (position) {
                setState(() {
                  _kGooglePlex = CameraPosition(
                    target: position.target,
                  );
                });
              },
            ),
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 42.0),
                child: Icon(
                  Icons.location_pin,
                  size: 50,
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.35,
                width: MediaQuery.of(context).size.width * .70,
                child: Center(
                  child: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: loading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator())
                        : Text(
                            currentLocation,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * .92,
        child: CustomButton(
          onPressed: currentLocation.isNotEmpty ? handleTap : null,
          buttonText: "Confirm",
        ),
      ),
    );
  }

  onMarkMoving() async {
    setState(() {
      loading = true;
    });
    final coordinates = Coordinates(
        _kGooglePlex!.target.latitude, _kGooglePlex!.target.longitude);
    List<Address> placemarks =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      location = LocationPoint(
          type: "Point",
          address: placemarks.reversed.last.addressLine,
          city: placemarks.reversed.last.locality,
          state: placemarks.reversed.last.adminArea,
          street: placemarks.reversed.last.subLocality,
          zipCode: placemarks.reversed.last.postalCode,
          coordinates: [
            _kGooglePlex!.target.latitude,
            _kGooglePlex!.target.longitude,
          ]);
      currentLocation = location?.address ?? '';
      loading = false;
    });
  }

  void handleTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfficeLocationView(
            locationPoint: location!,
          ),
        ));
  }
}
