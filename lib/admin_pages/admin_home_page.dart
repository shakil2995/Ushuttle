import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/admin_pages/Admin_Profile/admin_profile_page.dart';
import 'package:ushuttlev1/admin_pages/Admin_Ticket/admin_ticket_page.dart';
import 'package:ushuttlev1/admin_pages/Admin_Map/live_location_server.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

import 'Admin_Menu/admin_home_page.dart';

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
    const AdminTicketPage(),
    const AdminProfilePage(),
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
                Icons.menu,
              ),
              label: 'Menu'),
          NavigationDestination(
              icon: Icon(Icons.qr_code_scanner), label: 'Scanner'),
          NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
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
