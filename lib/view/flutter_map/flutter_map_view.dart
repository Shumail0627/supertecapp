// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class FlutterMapView extends StatefulWidget {
//   const FlutterMapView({super.key, this.lat, this.long});
//   final String? lat;
//   final String? long;
//   @override
//   State<FlutterMapView> createState() => _FlutterMapViewState();
// }

// class _FlutterMapViewState extends State<FlutterMapView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         options: MapOptions(
//             initialCenter:
//                 LatLng(double.parse(widget.lat!), double.parse(widget.long!)),
//             initialZoom: 18),
//         children: [
//           TileLayer(
//             urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 width: 80.0,
//                 height: 80.0,
//                 point: LatLng(
//                     double.parse(widget.lat!), double.parse(widget.long!)),
//                 child: const Icon(
//                   Icons.location_on,
//                   size: 40,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
