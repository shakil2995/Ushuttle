// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// // import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// //  variables
// var lng = 90.381035;
// var lat = 23.874191;

// // Run app
// void main() {
//   runApp(MaterialApp(
//     home: LiveMapPage(),
//   ));
// }

// class LiveMapPage extends StatefulWidget {
//   @override
//   State<LiveMapPage> createState() => _LiveMapPageState();
// }

// class _LiveMapPageState extends State<LiveMapPage> {
//   final mapController = MapController();
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Use `MapController` as needed
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     FlutterMap(
//       mapController: mapController,
//       options: MapOptions(
//           center: LatLng(lat, lng),
//           zoom: 13.0,
//           maxZoom: 18.0,
//           minZoom: 5.0,
//           onTap: (LatLng latLng) {
//             print(latLng);
//           }),
//     );
// //  load current location permission
//     Future<Position> getUserCurrentLocation() async {
//       await Geolocator.requestPermission()
//           .then((value) {})
//           .onError((error, stackTrace) {});
//       return await Geolocator.getCurrentPosition();
//     }

// //  load user current location
//     LatLng getCurrentLocation() {
//       getUserCurrentLocation().then(
//         (value) {
//           lat = value.latitude;
//           lng = value.longitude;
//           print('My current location');
//           print(value.latitude.toString() + " " + value.longitude.toString());
//         },
//       );

//       return LatLng(lat, lng);
//     }

// //  get bus location
//     LatLng getBusCurretLocation() {
//       return LatLng(23.875246, 90.389599);
//     }

//     // if (lat == 0.0 && lng == 0.0) {
//     //   print('latlng not working');
//     //   getCurrentLocation();
//     // }

//     //  markers
//     var marker = <Marker>[];
//     marker = [
//       Marker(
//         point: LatLng(lat, lng),
//         builder: (ctx) => const Icon(
//           Icons.location_on,
//           color: Colors.blue,
//           size: 40,
//         ),
//       ),
//       Marker(
//         point: getBusCurretLocation(),
//         builder: (ctx) => const Icon(
//           Icons.bus_alert,
//           size: 40,
//         ),
//       ),
//     ];

//     return Scaffold(
// // add floating action button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           getCurrentLocation();
//           setState(
//             () {
//               // FlutterMap(
//               //   options: MapOptions(
//               //     center: LatLng(0, 0),
//               //     zoom: 26,
//               //   ),
//               // );
//               // MarkerLayerOptions(markers: marker);
//             },
//           );
//         },
//         child: const Icon(Icons.my_location),
//         // backgroundColor: Colors.blue,
//       ),

//       // showing map
//       body: Center(
//         child: Column(
//           children: [
//             Flexible(
//               child: FlutterMap(
//                 mapController: MapController(),
//                 options: MapOptions(
//                   center: LatLng(lat, lng),
//                   // center: MapController().center,

//                   zoom: 16,
//                   maxZoom: 19,
//                   // bounds: LatLngBounds(
//                   //   LatLng(23.970758, 90.411709),
//                   //   LatLng(23.680452, 90.422657),
//                   // ),
//                 ),
//                 children: [],
//                 layers: [
//                   TileLayerOptions(
//                     urlTemplate:
//                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   ),
//                   MarkerLayerOptions(markers: marker),
//                   PolygonLayerOptions(
//                     polygons: [
//                       Polygon(
//                         color: Colors.black.withOpacity(0.3),
//                         borderColor: Colors.black,
//                         borderStrokeWidth: 3.0,
//                         isDotted: true,
//                         points: [
//                           getCurrentLocation(),
//                           getBusCurretLocation(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
