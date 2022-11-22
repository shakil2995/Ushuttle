import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiTest extends StatefulWidget {
  const RestApiTest({super.key});
  @override
  State<RestApiTest> createState() => _RestApiTestState();
}

class _RestApiTestState extends State<RestApiTest> {
  List<dynamic> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchCoordinates();
        },
        child: const Text('Fetch'),
      ),
      appBar: AppBar(
        title: const Text('Notice'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline))
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final busNo = item['busNo'];
          var latitude = item['location']['coordinates']['latitude'];
          var longitude = item['location']['coordinates']['longitude'];
          latitude = double.parse(latitude);
          longitude = double.parse(longitude);
          return ListTile(
            title: Text(busNo.toString()),
            subtitle: (Text('$latitude $longitude')),
          );
        },
      ),
    );
  }

  void fetchCoordinates() async {
    const url = 'https://ushuttle-backend.herokuapp.com/coords';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      items = json['results'];
    });
  }
}
