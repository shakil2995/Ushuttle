import 'package:flutter/material.dart';
import 'package:ushuttlev1/home_page.dart';
import 'package:ushuttlev1/info_page.dart';
import 'package:ushuttlev1/profile_page.dart';
import 'live_location_page.dart';

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
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('Ushuttle'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const InfoPage();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.info_outline))
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
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
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
