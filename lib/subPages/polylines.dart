// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   // ...

// //   void _showRoute() async {
// //     // Make the API request and get the route data
// //     http.Response response = await getRoute(startLat, startLng, endLat, endLng);
// //     Map<String, dynamic> data = jsonDecode(response.body);
// //     List<dynamic> route = data['features'][0]['geometry']['coordinates'];

// //     // Parse the route data and draw the route on the map
// //     PolylinePoints polylinePoints = PolylinePoints();
// //     List<LatLng> points = polylinePoints.decodePolyline(route);
// //     setState(() {
// //       _polylines.clear();
// //       _polylines.add(Polyline(
// //         points: points,
// //         strokeWidth: 4,
// //         color: Colors.red,
// //       ));
// //     });
// //     LatLngBounds bounds = LatLngBounds.fromPoints(points);
// //     _controller.move(bounds.center, _controller.zoom);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// // // ...
// //       body: FlutterMap(
// //         mapController: _controller,
// //         options: MapOptions(
// //           center: LatLng(startLat, startLng),
// //           zoom: 13.0,
// //         ),
// //         layers: [
// //           TileLayerOptions(
// //             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// //             subdomains: ['a', 'b', 'c'],
// //           ),
// //           PolylineLayerOptions(polylines: _polylines),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:open_route_service/open_route_service.dart';

// Future<void> main() async {
//   // Initialize the OpenRouteService with your API key.
//   final OpenRouteService client = OpenRouteService(
//       apiKey: '5b3ce3597851110001cf62481b69c894b0194d69a49878b2167fac8c');

//   // Example coordinates to test between
//   const double startLat = 37.4220698;
//   const double startLng = -122.0862784;
//   const double endLat = 37.4111466;
//   const double endLng = -122.0792365;

//   // Form Route between coordinates
//   final List<ORSCoordinate> routeCoordinates =
//       await client.directionsRouteCoordsGet(
//     startCoordinate: ORSCoordinate(latitude: startLat, longitude: startLng),
//     endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
//   );

//   // Print the route coordinates
//   routeCoordinates.forEach(print);
//   // debugPrint('Route coordinates: $routeCoordinates');

//   // Map route coordinates to a list of LatLng (requires google_maps_flutter)
//   // to be used in Polyline
//   // final List<LatLng> routePoints = routeCoordinates
//   //     .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
//   //     .toList();

//   // Create Polyline (requires Material UI for Color)
//   // final Polyline routePolyline = Polyline(
//   //   polylineId: PolylineId('route'),
//   //   visible: true,
//   //   points: routePoints,
//   //   color: Colors.red,
//   //   width: 4,
//   // );

//   // Use Polyline to draw route on map or do anything else with the data :)
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:open_route_service/open_route_service.dart';

// Future<void> main() async {
//   // Initialize the OpenRouteService with your API key.
//   final OpenRouteService client = OpenRouteService(
//       apiKey: '5b3ce3597851110001cf62481b69c894b0194d69a49878b2167fac8c');

//   // Example coordinates to test between
//   const double startLat = 37.4220698;
//   const double startLng = -122.0862784;
//   const double endLat = 37.4111466;
//   const double endLng = -122.0792365;

//   // Form Route between coordinates
//   final List<ORSCoordinate> routeCoordinates =
//       await client.directionsRouteCoordsGet(
//     startCoordinate: ORSCoordinate(latitude: startLat, longitude: startLng),
//     endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
//   );

//   // Map route coordinates to a list of LatLng (required by flutter_map)
//   final List<LatLng> routePoints = routeCoordinates
//       .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
//       .toList();

//   // Create a PolylineLayerOptions object to hold the polyline options
//   final PolylineLayer polylineOptions = PolylineLayer(
//     polylines: [
//       Polyline(
//         points: routePoints,
//         strokeWidth: 4,
//         // color: Colors.red,
//       ),
//     ],
//   );

//   // Initialize the map controller
//   final MapController mapController = MapController();

//   // Set the starting center and zoom level of the map
//   final LatLng center = routePoints[routePoints.length ~/ 2];
//   final int zoom = 16;

//   // Build the FlutterMap widget
//   final FlutterMap map = FlutterMap(
//     mapController: mapController,
//     options: MapOptions(
//       center: center,
//       // zoom: zoom,
//     ),
//     children: [
//       TileLayer(
//         urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//         subdomains: ['a', 'b', 'c'],
//       ),
//       polylineOptions,
//     ],
//   );

//   // Use the FlutterMap widget in your app
// }
