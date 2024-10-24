import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key, this.lat, this.long});
  final String? lat;
  final String? long;

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Completer<GoogleMapController> mapController = Completer();
  final List<Marker> _mark = [];
  late final List<Marker> _list;

  @override
  void initState() {
    super.initState();
    _list = [
      Marker(
        markerId: const MarkerId('office'),
        position: LatLng(
          double.parse(widget.lat!),
          double.parse(widget.long!),
        ),
      )
    ];
    _mark.addAll(_list);
    setLocation();
  }

  void setLocation() async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(double.parse(widget.lat!), double.parse(widget.long!)),
            zoom: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          // buildingsEnabled: true,
          mapType: MapType.normal,
          markers: Set<Marker>.of(_mark),
          initialCameraPosition:
              const CameraPosition(target: LatLng(35.6764, 139.6500), zoom: 20),
          onMapCreated: (GoogleMapController controller) {
            mapController.complete(controller);
          },
        ),
      ),
    );
  }
}
