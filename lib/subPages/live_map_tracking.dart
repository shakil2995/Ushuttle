import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_example/widgets/drawer.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:latlong2/latlong.dart';
var lng = 90.381035;
var lat = 23.874191;

class MapControllerPage extends StatefulWidget {
  static const String route = 'map_controller';

  const MapControllerPage({Key? key}) : super(key: key);

  @override
  MapControllerPageState createState() {
    return MapControllerPageState();
  }
}

final LatLng dhaka = LatLng(23.875246, 90.389599);

class MapControllerPageState extends State<MapControllerPage> {
  late final MapController _mapController;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

//  load current location permission
  Future<Position> getLocationPermission() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }

//  load user current location
  LatLng getCurrentUserLocation() {
    getLocationPermission().then(
      (value) {
        lat = value.latitude;
        lng = value.longitude;
        print('My current location');
        print(value.latitude.toString() + " " + value.longitude.toString());
      },
    );

    return LatLng(lat, lng);
  }

//  get bus location
  LatLng getBusCurretLocation() {
    return LatLng(23.875246, 90.389599);
  }

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        // width: 80,
        // height: 80,
        point: LatLng(lat, lng),
        builder: (ctx) => Container(
          key: const Key('blue'),
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      ),
      Marker(
        // width: 80,
        // height: 80,
        point: getBusCurretLocation(),
        builder: (ctx) => Container(
          key: const Key('blue'),
          child: const Icon(
            Icons.bus_alert,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
    ];

    return Scaffold(
      // appBar: AppBar(title: const Text('MapController')),
      // drawer: buildDrawer(context, MapControllerPage.route),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      _mapController.move(getBusCurretLocation(), 16);
                    },
                    // child: const Text('Locate Bus'),
                    child: const Icon(
                      Icons.bus_alert,
                      color: Colors.black,
                      // size: 40,
                    ),
                  ),
                  CurrentLocation(mapController: _mapController),
                ],
              ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(23.811941, 90.421374),
                  zoom: 12,
                  maxZoom: 18,
                  minZoom: 8,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({
    Key? key,
    required this.mapController,
  }) : super(key: key);

  final MapController mapController;
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  int _eventKey = 0;

  IconData icon = Icons.gps_not_fixed;
  late final StreamSubscription<MapEvent> mapEventSubscription;

  @override
  void initState() {
    super.initState();
    mapEventSubscription =
        widget.mapController.mapEventStream.listen(onMapEvent);
  }

  @override
  void dispose() {
    mapEventSubscription.cancel();
    super.dispose();
  }

  void setIcon(IconData newIcon) {
    if (newIcon != icon && mounted) {
      setState(() {
        icon = newIcon;
      });
    }
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is MapEventMove && mapEvent.id != _eventKey.toString()) {
      setIcon(Icons.gps_not_fixed);
    }
  }

  void _moveToCurrent() async {
    _eventKey++;
    final location = Location();

    try {
      final currentLocation = await location.getLocation();
      final moved = widget.mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        17,
        id: _eventKey.toString(),
      );

      setIcon(moved ? Icons.gps_fixed : Icons.gps_not_fixed);
    } catch (e) {
      setIcon(Icons.gps_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: _moveToCurrent,
    );
  }
}
