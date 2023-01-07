import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/qrScanners/scan_ticket_scanner.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/qrScanners/sell_ticket_scanner.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class AdminTicketPage extends StatefulWidget {
  const AdminTicketPage({super.key});

  @override
  State<AdminTicketPage> createState() => _AdminTicketPageState();
}

class _AdminTicketPageState extends State<AdminTicketPage> {
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
            buttonWidget(
              title: 'Sell Credits',
              icon: Icons.sell,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SellTicketScanner();
                    },
                  ),
                );
              },
              backgroundColor: scheduleColor,
              isDark: themeProvider.isDark,
            ),
            buttonWidget(
              title: 'Scan Credits',
              icon: Icons.qr_code_scanner,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ScanTicket();
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
