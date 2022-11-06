import 'package:flutter/material.dart';

class FarePage extends StatelessWidget {
  const FarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fare'),
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
