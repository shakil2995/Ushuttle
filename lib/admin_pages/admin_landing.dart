import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/admin_ticket_page.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/live_location_server.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';
import 'package:ushuttlev1/MainMenu/home_page.dart';
import 'package:ushuttlev1/MainMenu/profile_page.dart';

import 'admin_subpages/admin_home_page.dart';

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({super.key});

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  int currentPage = 0;
  List<Widget> pages = [
    // const LiveMapPage(),
    const LiveLocationServer(),
    const AdminHomePage(),
    const AdminTicketPage()
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('Ushuttle Admin'),
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
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          // NavigationDestination(icon: Icon(Icons.map), label: 'Track'),
          NavigationDestination(
            icon: Icon(Icons.pin_drop),
            label: 'Live',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.qr_code_scanner), label: 'Scanner'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
            // debugPrint(currentPage.toString());
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
