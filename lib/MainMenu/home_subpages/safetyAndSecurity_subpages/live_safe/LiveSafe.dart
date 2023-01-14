import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/safetyAndSecurity_subpages/live_safe/pharmacyCard.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/safetyAndSecurity_subpages/live_safe/policeStationCard.dart';

import 'BusStationCard.dart';
import 'HospitalCard.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(onMapFunction: openMap),
          HospitalCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusStationCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}
