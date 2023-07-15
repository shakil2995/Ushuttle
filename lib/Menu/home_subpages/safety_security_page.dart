// import 'dart:convert';
// import 'package:expandable/expandable.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/Menu/home_subpages/safetyAndSecurity_subpages/live_safe/LiveSafe.dart';
import 'package:ushuttlev1/Menu/home_subpages/safetyAndSecurity_subpages/ambulance_emergency.dart';
import 'package:ushuttlev1/Menu/home_subpages/safetyAndSecurity_subpages/firefighter_emergency.dart';
import 'package:ushuttlev1/Menu/home_subpages/safetyAndSecurity_subpages/police_emergency.dart';
import 'package:ushuttlev1/Menu/home_subpages/safetyAndSecurity_subpages/live_safe/safe_home/safeHome.dart';
import 'package:ushuttlev1/Menu/home_subpages/safetyAndSecurity_subpages/ushuttle_helpdesk.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

class SafetyAndSecurityPage extends StatefulWidget {
  const SafetyAndSecurityPage({super.key});

  @override
  State<SafetyAndSecurityPage> createState() => _SafetyAndSecurityPageState();
}

class _SafetyAndSecurityPageState extends State<SafetyAndSecurityPage> {
  bool isLoading = false;
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Safety & Security'),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    themeProvider.toggleTheme();
                  });
                },
                icon: Icon(!themeProvider.isDark
                    ? Icons.sunny
                    : Icons.nightlight_round_outlined))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Emergency contacts',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDark
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 35, 35, 35),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  child: ListView(
                    // physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      PoliceEmergency(),
                      FirefighterEmergency(),
                      AmbulanceEmergency(),
                      UshuttleHelpDesk()
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Explore LiveSafe',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDark
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 35, 35, 35),
                      )),
                ),
                LiveSafe(),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Stay Connected',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDark
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 35, 35, 35),
                      )),
                ),
                SizedBox(height: 5),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: SafeHome()),
                )
              ],
            ),
          ),
        ));
  }
}
