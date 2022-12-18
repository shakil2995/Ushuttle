import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
// import 'package:geolocator/geolocator.dart';

var lat = 23.874191;
var lng = 90.381035;

List<dynamic> items = [];

final item = items[0];
var busNo = item['busNo'];
var latitude = item['location']['coordinates']['latitude'];
var longitude = item['location']['coordinates']['longitude'];
LatLng buslocation = LatLng(lat, lng);
// latitude = double.parse(latitude);
// longitude = double.parse(longitude);

class LiveLocationPage extends StatefulWidget {
  // static const String route = '/live_location';

  const LiveLocationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage>
    with AutomaticKeepAliveClientMixin<LiveLocationPage> {
  LocationData? _currentLocation;
  late final MapController _mapController;

  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  int interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    // await _locationService.changeSettings(
    //   accuracy: geoLocator.LocationAccuracy.high,
    //   interval: 100,
    // );
//  load current location permission
    // Future<Position> getLocationPermission() async {
    //   await Geolocator.requestPermission()
    //       .then((value) {})
    //       .onError((error, stackTrace) {});
    //   return await Geolocator.getCurrentPosition();
    // }

//  load user current location
    // LatLng getCurrentUserLocation() {
    //   getLocationPermission().then(
    //     (value) {
    //       lat = value.latitude;
    //       lng = value.longitude;
    //     },
    //   );

    //   return LatLng(lat, lng);
    // }

    LocationData? location;
    bool serviceEnabled;
    // bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          startFetchingCoordinates();
          _liveUpdate = !_liveUpdate;

          if (_liveUpdate) {
            interActiveFlags = InteractiveFlag.rotate |
                InteractiveFlag.pinchZoom |
                InteractiveFlag.doubleTapZoom;

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('In live update mode only zoom and rotation are enable'),
            ));
          } else {
            interActiveFlags = InteractiveFlag.all;
          }

          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;

                // If Live Update is enabled, move map center
                if (_liveUpdate) {
                  _mapController.move(
                      LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      _mapController.zoom);
                }
              });
            }
          });
        }
        // } else {
        //   serviceRequestResult = await _locationService.requestService();
        //   if (serviceRequestResult) {
        //     initLocationService();
        //     return;
        //   }
        // }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Location Permission Required'),
              content: const Text(
                  'Please grant location permission to use this feature.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;
    // LatLng currentBusLatLng = LatLng(lat, lng);
// add 2 second delay
    Future.delayed(const Duration(seconds: 5), () {});
    // Until currentLocation is initially updated, Widget can locate to 23.809320, 90.397847
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(23.809320, 90.397847);
    }

    final markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: currentLatLng,
        builder: (ctx) => const Icon(Icons.location_on, size: 50),
      ),
    ];
    final busMarkers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: buslocation,
        builder: (ctx) => const Icon(Icons.bus_alert, size: 50),
      ),
    ];
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 0, bottom: 0),
            //   child: _serviceError!.isEmpty
            //       ? Text('This is a map that is showing '
            //           '(${currentLatLng.latitude}, ${currentLatLng.longitude}).')
            //       : Text(
            //           'Error occured while acquiring location. Error Message : '
            //           '$_serviceError'),
            // ),
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                // options: MapOptions(
                //   center:
                //       LatLng(currentLatLng.latitude, currentLatLng.longitude),
                //   zoom: 16,
                //   maxZoom: 18,
                //   interactiveFlags: interActiveFlags,
                // ),
                options: MapOptions(
                  center: LatLng(23.819158502556704, 90.3990976172065),
                  minZoom: 13,
                  zoom: 16,
                  maxZoom: 17,
                  swPanBoundary: LatLng(
                    23.751602244953595,
                    90.347598978984,
                  ),
                  nePanBoundary: LatLng(23.886714760159808, 90.450596255428991),
                  interactiveFlags: interActiveFlags,
                ),
                children: [
                  TileLayer(
                    tileProvider: AssetTileProvider(),
                    maxZoom: 17,
                    urlTemplate: 'assets/map/dhaka/{z}/{x}/{y}.png',
                  ),
                  // TileLayer(
                  //   urlTemplate:
                  //       'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //   userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  // ),
                  MarkerLayer(markers: markers),
                  MarkerLayer(markers: busMarkers),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          onPressed: () {
            setState(() {
              _liveUpdate = !_liveUpdate;

              if (_liveUpdate) {
                startFetchingCoordinates();
                interActiveFlags = InteractiveFlag.rotate |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.doubleTapZoom;

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'In live update mode only zoom and rotation are enable'),
                ));
              } else {
                interActiveFlags = InteractiveFlag.all;
              }
            });
          },
          child: _liveUpdate
              ? const Icon(Icons.location_on)
              : const Icon(Icons.location_off),
        );
      }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void fetchCoordinates() async {
    const url = 'http://localhost:3000/coords';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      items = json["results"];
      // debugPrint(items[0].results);
    });
  }

  void startFetchingCoordinates() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      fetchCoordinates();
      final item = items[0];
      busNo = item['busNo'];
      latitude = double.parse(item['location']['coordinates']['latitude']);
      longitude = double.parse(item['location']['coordinates']['longitude']);
      debugPrint('busNo: $busNo');
      if (mounted) {
        setState(() {
          buslocation = LatLng(latitude, longitude);
        });
      }
    });
  }
}


//  void getLocation() async {
//     final response = await http.get('https://api.example.com/location');
//     if (response.statusCode == 200) {
//       final location = response.body;
//       setState(() {
//         _currentLocation = LatLng(location['latitude'], location['longitude']);
//       });
//       Timer.periodic(Duration(seconds: 10), (timer) async {
//         getLocation();
//       });
//     }
//   }