import 'package:flutter/material.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/fare_page.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/notice_page.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/schedule_page.dart';
import 'package:ushuttlev1/MainMenu/home_subpages/stoppage_page.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/admin_profile_page.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/admin_ticket_page.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Color darkTheme = Color.fromARGB(255, 70, 70, 70);
    // Color darkTheme = Colors.blueGrey.shade800;
    Color lightTheme = Colors.blue;

    Color scheduleColor = !themeProvider.isDark ? lightTheme : darkTheme;
    Color fareColor = !themeProvider.isDark ? lightTheme : darkTheme;
    Color stoppageColor = !themeProvider.isDark ? lightTheme : darkTheme;
    Color noticeColor = !themeProvider.isDark ? lightTheme : darkTheme;
    Color ticketColor = !themeProvider.isDark ? lightTheme : darkTheme;
    return Scaffold(
      // appBar: AppBar(title: const Text('Grid')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: [
            buttonWidget(
              title: 'Schedule',
              icon: Icons.schedule,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const SchedulePage();
                    },
                  ),
                );
              },
              backgroundColor: scheduleColor,
              isDark: themeProvider.isDark,
            ),
            buttonWidget(
              title: 'Fare',
              icon: Icons.currency_exchange,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const FarePage();
                    },
                  ),
                );
              },
              backgroundColor: fareColor,
              isDark: themeProvider.isDark,
            ),
            buttonWidget(
              title: 'Stoppage',
              icon: Icons.bus_alert,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const StoppagePage();
                    },
                  ),
                );
              },
              backgroundColor: stoppageColor,
              isDark: themeProvider.isDark,
            ),
            buttonWidget(
              title: 'Notice',
              icon: Icons.notifications,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const NoticePage();
                    },
                  ),
                );
              },
              backgroundColor: noticeColor,
              isDark: themeProvider.isDark,
            ),
            buttonWidget(
              title: 'Profile',
              icon: Icons.person,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AdminProfilePage();
                    },
                  ),
                );
              },
              backgroundColor: ticketColor,
              isDark: themeProvider.isDark,
            ),
            // buttonWidget(
            //   title: 'Scanner',
            //   icon: Icons.qr_code_scanner,
            //   onPress: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (BuildContext context) {
            //           return AdminTicketPage();
            //         },
            //       ),
            //     );
            //   },
            //   backgroundColor: ticketColor,
            //   isDark: themeProvider.isDark,
            // ),
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
              size: 50,
              // color: isDark ? Colors.white : Colors.black,
              color: Colors.white,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  // color: isDark ? Colors.white : Colors.black, fontSize: 20),
                  color: Colors.white,
                  fontSize: 16),
            )
          ],
        ),
        // child: const Text('Elevated Button'),
      ),
    );
  }
}