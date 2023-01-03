import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ushuttlev1/admin_pages/admin_subpages/qrScanners/scan_ticker_scanner.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/qrScanners/sell_ticker_scanner.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class AdminTicketPage extends StatefulWidget {
  const AdminTicketPage({super.key});

  @override
  State<AdminTicketPage> createState() => _AdminTicketPageState();
}

class _AdminTicketPageState extends State<AdminTicketPage> {
  get _currentLocation => null;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Color darkTheme = Color.fromARGB(255, 70, 70, 70);
    // Color darkTheme = Colors.blueGrey.shade800;
    Color lightTheme = Colors.blue;

    Color scheduleColor = !themeProvider.isDark ? lightTheme : darkTheme;
    Color fareColor = !themeProvider.isDark ? lightTheme : darkTheme;
    return Scaffold(
      // appBar: AppBar(title: const Text('Grid')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            // crossAxisSpacing: 10,
            // mainAxisSpacing: 10,

            childAspectRatio: 1.3,
          ),
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: [
            //       Text(
            //         _currentLocation != null
            //             ? 'Bus Location ${_currentLocation?.latitude!} ${_currentLocation?.longitude!}'
            //             : 'Finding your location...',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       TextButton(
            //           style: ButtonStyle(
            //             textStyle: MaterialStateProperty.all<TextStyle>(
            //               const TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             backgroundColor: MaterialStateProperty.all<Color>(
            //               _currentLocation != null
            //                   ? Color.fromARGB(255, 60, 255, 106)
            //                   : Color.fromARGB(255, 255, 68, 68),
            //             ),
            //           ),
            //           onPressed: () {},
            //           child: Text(
            //               _currentLocation != null
            //                   ? 'Sharing live location'
            //                   : 'Starting live location',
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //               ))),
            //     ],
            //   ),
            // ),
            buttonWidget(
              title: 'Sell Tickets',
              icon: Icons.sell,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ScanSellQrScanner();
                    },
                  ),
                );
              },
              backgroundColor: scheduleColor,
              isDark: themeProvider.isDark,
            ),
            buttonWidget(
              title: 'Scan Tickets',
              icon: Icons.qr_code_scanner,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ScanQrScanner();
                    },
                  ),
                );
              },
              backgroundColor: fareColor,
              isDark: themeProvider.isDark,
            ),
          ],
        ),
      ),
    );
  }
}

class buttonWidget extends StatelessWidget {
  const buttonWidget(
      {Key? key,
      required this.title,
      required this.icon,
      this.onPress,
      this.textColor,
      this.backgroundColor,
      required this.isDark})
      : super(key: key);
  final String title;
  final IconData icon;
  final bool isDark;
  final VoidCallback? onPress;
  final Color? textColor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        onPressed: onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              // Icons.schedule,
              size: 70,
              // color: isDark ? Colors.white : Colors.black,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  // color: isDark ? Colors.white : Colors.black, fontSize: 20),
                  color: Colors.white,
                  fontSize: 22),
            )
          ],
        ),
        // child: const Text('Elevated Button'),
      ),
    );
  }
}
