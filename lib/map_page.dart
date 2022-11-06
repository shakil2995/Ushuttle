import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Container(
          //   margin: const EdgeInsets.all(10.0),
          //   padding: const EdgeInsets.all(10.0),
          //   color: Colors.blueGrey,
          //   width: double.infinity,
          //   child: const Center(
          //     child: Text('Map', style: TextStyle(color: Colors.white)),
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.all(10.0),
          //   padding: const EdgeInsets.all(10.0),
          //   color: Colors.blueGrey,
          //   width: double.infinity,
          //   child: const Center(
          //     child: Text('This is a text widget',
          //         style: TextStyle(color: Colors.white)),
          //   ),
          // ),
          Image.network(
              'https://media.istockphoto.com/photos/closeup-picture-of-a-busy-paper-map-of-florida-picture-id185076557')
        ],
      )),
    );
  }
}
