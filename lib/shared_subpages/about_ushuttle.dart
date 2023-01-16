import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About ushuttle'),
        automaticallyImplyLeading: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         debugPrint('Action');
        //       },
        //       icon: const Icon(Icons.info_outline))
        // ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: double.infinity,
            child: const Center(
              child: Text(
                  'This app is still in development and is not ready for production use.',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: double.infinity,
            child: const Center(
              child: Text(
                  'Created by Ushuttle Team.\nFor any queries, please contact us.',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: double.infinity,
            child: const Center(
              child: Text('App version : 0.9.0 (Beta release))',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      )),
    );
  }
}
