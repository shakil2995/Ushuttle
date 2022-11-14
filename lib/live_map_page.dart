import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

var lat = 23.874370;
var lng = 90.390766;
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
// markers

//  load current location permission
    getCurrentLocation() {
      Future<Position> getUserCurrentLocation() async {
        await Geolocator.requestPermission()
            .then((value) {})
            .onError((error, stackTrace) {});
        return await Geolocator.getCurrentPosition();
      }

//  load user current location
      getUserCurrentLocation().then((value) {
        lat = value.latitude;
        lng = value.longitude;
        print('My current location');
        print(value.latitude.toString() + " " + value.longitude.toString());
      });
    }

    @override
    void initState() {
      super.initState();
      getCurrentLocation();
    }

    var marker = <Marker>[];
    marker = [
      // Marker(
      //   point: LatLng(23.874370, 90.390766),
      //   builder: (ctx) => const Icon(
      //     Icons.circle_sharp,
      //     color: Colors.blue,
      //     // size: 28,
      //   ),
      // ),
      // Marker(
      //   point: LatLng(23.875246, 90.389599),
      //   builder: (ctx) => Icon(Icons.bus_alert),
      // ),
      // Marker(
      //   point: LatLng(23.864370, 90.390766),
      //   builder: (ctx) => Icon(Icons.circle),
      // ),
    ];
    // loadData() {
    //     setState(() {
    //       marker.add(
    //         Marker(
    //           point: LatLng(lat, lng),
    //           builder: (ctx) => Icon(
    //             Icons.circle_sharp,
    //             color: Colors.blue,
    //           ),
    //         ),
    //       );
    //     });
    //   }

    return Scaffold(
// add floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
          setState(() {
            body:
            Center(
              child: Container(
                child: Column(
                  children: [
                    Flexible(
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(lat, lng),
                          zoom: 16,
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          MarkerLayerOptions(markers: marker),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        },
        child: const Icon(Icons.my_location),
        // backgroundColor: Colors.blue,
      ),
    );
  }
}
