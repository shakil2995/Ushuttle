import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/emergencies/ambulance_emergency.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/emergencies/firefighter_emergency.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/emergencies/police_emergency.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Emergency contacts',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
