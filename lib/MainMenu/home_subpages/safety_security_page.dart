import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        body: Column(
          children: [
            const Text('Safety and Security'),
          ],
        ));
  }
}
