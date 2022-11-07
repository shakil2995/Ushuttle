import 'dart:async';
// import 'package:permission/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ushuttlev1/constants.dart';

class LiveMapPage extends StatefulWidget {
  const LiveMapPage({Key? key}) : super(key: key);

  @override
  State<LiveMapPage> createState() => LiveMapPageState();
}

class LiveMapPageState extends State<LiveMapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
// connect points
  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     google_api_key,
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Live Map",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: sourceLocation,
            zoom: 13.5,
          ),
          markers: {
            const Marker(
                markerId: MarkerId("source"), position: sourceLocation),
            const Marker(
                markerId: MarkerId("destination"), position: destination),
          },
        ));
  }
}
