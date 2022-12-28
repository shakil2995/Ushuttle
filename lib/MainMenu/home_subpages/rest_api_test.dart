import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

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
          startFetchingCoordinates();
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
            title: Text('Bus no $busNo',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            subtitle: Text('Latitude: $latitude, Longitude: $longitude',
                style: const TextStyle(fontSize: 16)),
          );
        },
      ),
    );
  }

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
    });
  }
}
