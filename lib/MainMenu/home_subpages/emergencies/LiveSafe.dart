import 'package:flutter/material.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/emergencies/live_safe/policeStationCard.dart';

import 'live_safe/BusStationCard.dart';
import 'live_safe/HospitalCard.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(),
          HospitalCard(),
          BusStationCard(),
          PoliceStationCard(),
        ],
      ),
    );
  }
}
