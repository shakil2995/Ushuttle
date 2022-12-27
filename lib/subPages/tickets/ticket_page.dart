import 'package:flutter/material.dart';
import 'package:ushuttlev1/subPages/tickets/buy_ticket_page.dart';
import 'package:ushuttlev1/subPages/tickets/qrGenerator.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color darkTheme = Color.fromARGB(255, 70, 70, 70);
    Color lightTheme = Colors.blue;
    Color scheduleColor = !themeProvider.isDark ? lightTheme : darkTheme;
    Color fareColor = !themeProvider.isDark ? lightTheme : darkTheme;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('Tickets'),
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
      // appBar: AppBar(title: const Text('Grid')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyCardWidget(
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
              size: 50,
              // color: isDark ? Colors.white : Colors.black,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                    // color: isDark ? Colors.white : Colors.black, fontSize: 20),
                    color: Colors.white,
                    fontSize: 16),
              ),
            )
          ],
        ),
        // child: const Text('Elevated Button'),
      ),
    );
  }
}

class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key? key, required this.isDark}) : super(key: key);
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          height: 400,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            // color: Colors.red,
            elevation: 10,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.local_movies,
                    size: 100.0, color: !isDark ? Colors.blue : Colors.white),
                const ListTile(
                  leading: Icon(Icons.local_movies, size: 0),
                  title: Text('Bus Name',
                      style: TextStyle(
                        fontSize: 30.0,
                      )),
                  subtitle: Text('You have 6 tickets left.',
                      style: TextStyle(fontSize: 18.0)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        isDark ? Color.fromARGB(255, 197, 75, 75) : Colors.red,
                    disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  ),
                  child: const Text('Use Ticket'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return QrGenerator();
                        },
                      ),
                    );
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: isDark
                        ? Color.fromARGB(255, 67, 151, 75)
                        : Colors.green,
                    disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  ),
                  child: const Text('Buy More'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const BuyTicketPage();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
