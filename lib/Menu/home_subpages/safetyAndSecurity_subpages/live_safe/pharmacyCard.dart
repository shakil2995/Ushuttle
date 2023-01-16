import 'package:flutter/material.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class PharmacyCard extends StatelessWidget {
  final Function? onMapFunction;
  const PharmacyCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('Pharmacies near me');
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
                    Icons.local_pharmacy,
                    size: 50,
                    color: themeProvider.isDark
                        ? Color.fromARGB(255, 223, 87, 66)
                        : Color.fromARGB(255, 237, 90, 49),
                  ),
                ),
              ),
            ),
          ),
          Text('   Pharmacy   '),
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
