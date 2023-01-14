import 'package:flutter/material.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class BusStationCard extends StatelessWidget {
  final Function? onMapFunction;
  const BusStationCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('Bus stops near me');
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.directions_bus,
                    size: 50,
                    color: themeProvider.isDark
                        ? Color.fromARGB(255, 73, 145, 247)
                        : Color.fromARGB(255, 27, 122, 43),
                  ),
                ),
              ),
            ),
          ),
          Text('Bus Stations'),
          // Container(
          //   height: 70,
          //   width: 90,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Colors.red,
          //   ),
          // ),
          // const Text('Police Station'),
        ],
      ),
    );
  }
}
