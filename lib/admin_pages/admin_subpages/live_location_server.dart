import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:ushuttlev1/authentication_pages/auth.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
var lat = 23.874191;
var lng = 90.381035;
List<dynamic> items = [];
var busMarkers = <Marker>[];

class LiveLocationServer extends StatefulWidget {
  const LiveLocationServer({Key? key}) : super(key: key);
  @override
  _LiveLocationServerState createState() => _LiveLocationServerState();
}

class _LiveLocationServerState extends State<LiveLocationServer>
    with AutomaticKeepAliveClientMixin<LiveLocationServer> {
  LocationData? _currentLocation;
  late final MapController _mapController;
  bool _liveUpdate = false;
  bool _permission = false;
  String? _serviceError = '';
  int interActiveFlags = InteractiveFlag.all;
  final Location _locationService = Location();
  // void fetchCoordinates() async {
  //   getBusLocation(instituteId) async {
  //     var url = 'https://busy-jay-earrings.cyclic.app/coords/${instituteId}';
  //     final uri = Uri.parse(url);
  //     final response = await http.get(uri);
  //     final body = response.body;
  //     final json = jsonDecode(body);
  //     if (mounted) {
  //       setState(() {
  //         items = json["results"];
  //       });
  //     }
  //   }
  //   getDocIds() async {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('email', isEqualTo: user?.email)
  //         .get()
  //         .then((snapshot) {
  //       snapshot.docs.forEach((document) {
  //         // Access the data in the document
  //         var data = document.data();
  //         String instituteId = data['institute'];
  //         debugPrint('${instituteId}');
  //         getBusLocation(instituteId);
  //         // Do something with the data
  //       });
  //     });
  //   }

  //   getDocIds();
  // }

  void startFetchingCoordinates() {
    int timerVal = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timerVal++;
      if (timerVal == 3) {
        // fetchCoordinates();
        if (mounted) {
          // debugPrint('timer mounted');
          setState(() {
            busMarkers.clear();
            if (items.isNotEmpty) {
              items.forEach((element) {
                busMarkers.add(
                  Marker(
                    rotate: true,
                    width: 80,
                    height: 80,
                    point: LatLng(
                      double.parse(
                          element['location']['coordinates']['latitude']),
                      double.parse(
                          element['location']['coordinates']['longitude']),
                    ),
                    builder: (ctx) => const Icon(
                      Icons.directions_bus,
                      size: 50,
                      color: Color.fromARGB(255, 4, 4, 4),
                    ),
                  ),
                );
              });
            } else {
              debugPrint('no data');
            }
            // buslocation = LatLng(latitude, longitude);
          });
        } else {
          // debugPrint('timer dismounted');
          timer.cancel();
        }
        timerVal = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
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
            if (mounted) {
              setState(() {
                interActiveFlags = InteractiveFlag.all &
                    ~InteractiveFlag.rotate &
                    ~InteractiveFlag.pinchZoom;
              });
            }
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
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('GPS Required'),
              content: const Text('Please turn on GPS to use this feature.'),
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
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(23.809320, 90.397847);
    }
    final markers = <Marker>[
      Marker(
        rotate: true,
        width: 80,
        height: 80,
        point: currentLatLng,
        builder: (ctx) => const Icon(
          Icons.location_on,
          size: 50,
          color: Color.fromARGB(255, 4, 4, 4),
        ),
      ),
    ];
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
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
          backgroundColor: Color.fromARGB(255, 13, 13, 13),
          onPressed: () {
            setState(() {
              _liveUpdate = !_liveUpdate;

              if (_liveUpdate) {
                if (_currentLocation != null) {
                  _mapController.move(
                      LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      _mapController.zoom);
                  startFetchingCoordinates();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        // 'In live update mode only zoom and rotation are enabled'),
                        'locating you...'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please turn on GPS to use this feature.'),
                  ));
                }
              } else {
                interActiveFlags = InteractiveFlag.all;
              }
            });
          },
          child: _liveUpdate
              ? const Icon(
                  Icons.gps_fixed,
                  color: Color.fromARGB(255, 251, 250, 250),
                )
              : const Icon(
                  Icons.location_searching,
                  color: Color.fromARGB(255, 254, 251, 251),
                ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
