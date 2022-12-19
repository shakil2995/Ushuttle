import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
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
            color: Colors.blueGrey,
            width: double.infinity,
            child: const Center(
              child: Text(
                  'This app aims to automate most of the manual tasks for Ushuttle Team.\nFlutter and express.js was used to create this app.',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      )),
    );
  }
}
