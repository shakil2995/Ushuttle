import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/Ticket/ticket_page.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';
import 'package:ushuttlev1/Menu/home_page.dart';
import 'package:ushuttlev1/Profile/profile_page.dart';

import 'Map/live_location_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = [
    // const LiveMapPage(),
    const LiveLocationPage(),
    const HomePage(),
    const TicketPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('Ushuttle'),
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
              icon: Icon(Icons.local_movies), label: 'Ticket'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
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
