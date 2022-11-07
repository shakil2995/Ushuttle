import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveMapPage extends StatefulWidget {
  const LiveMapPage({Key? key}) : super(key: key);

  @override
  State<LiveMapPage> createState() => LiveMapPageState();
}

class LiveMapPageState extends State<LiveMapPage> {
  // final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Live Map",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        body: const GoogleMap(
          initialCameraPosition:
              CameraPosition(target: sourceLocation, zoom: 14.5),
        ));
  }
}
