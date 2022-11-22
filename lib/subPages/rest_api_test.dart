import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiTest extends StatefulWidget {
  const RestApiTest({super.key});

  @override
  State<RestApiTest> createState() => _RestApiTestState();
}

class _RestApiTestState extends State<RestApiTest> {
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchCoordinates();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Notice'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                debugPrint('Action');
              },
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: const Center(
        child: Text('RestApiTest'),
      ),
    );
  }

  void fetchCoordinates() async {
    // ignore: avoid_print
    print("coordinates");
    const url = 'https://ushuttle-backend.herokuapp.com/coords';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      data = json['data'];
    });
    print('fetched data');
  }
}
