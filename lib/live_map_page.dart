import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MaterialApp(
    home: LiveMapPage(),
  ));
}

class LiveMapPage extends StatefulWidget {
  @override
  State<LiveMapPage> createState() => _LiveMapPageState();
}

class _LiveMapPageState extends State<LiveMapPage> {
  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];

    marker = [
      Marker(
        point: LatLng(23.874370, 90.390766),
        builder: (ctx) => const Icon(
          Icons.circle_sharp,
          color: Colors.blue,
          // size: 28,
        ),
      ),
      Marker(
        point: LatLng(23.875246, 90.389599),
        builder: (ctx) => Icon(Icons.bus_alert),
      ),
      // Marker(
      //   point: LatLng(23.864370, 90.390766),
      //   builder: (ctx) => Icon(Icons.circle),
      // ),
    ];

    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(23.874370, 90.390766),
                  zoom: 16,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayerOptions(markers: marker)
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
