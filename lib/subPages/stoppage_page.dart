import 'package:flutter/material.dart';

class StoppagePage extends StatelessWidget {
  const StoppagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stoppage'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                debugPrint('Action');
              },
              icon: const Icon(Icons.info_outline))
        ],
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
              child: Text('info', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      )),
    );
  }
}
