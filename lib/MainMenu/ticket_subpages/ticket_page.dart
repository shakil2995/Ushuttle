import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ushuttlev1/authentication_pages/auth.dart';
import 'package:ushuttlev1/MainMenu/ticket_subpages/qrGenerator.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
List<dynamic> items = [];
int userTicketCount = 0;
String instituteId = '';
bool isLoaded = false;

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});
  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  void fetchUserData() async {
    getDocIds() async {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user?.email)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((document) {
          // Access the data in the document
          var data = document.data();
          // print(data);
          instituteId = data['institute'];
          int ticket = data['credit'];
          if (mounted) {
            setState(() {
              userTicketCount = ticket;
              isLoaded = true;
            });
          }
        });
      });
    }

    getDocIds();
  }

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('My Credits'),
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
      body: bodyWidget(themeProvider),
    );
  }

  Padding bodyWidget(ThemeProvider themeProvider) {
    if (isLoaded) {
      return Padding(
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
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
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
              size: 50,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
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
            // color: !isDark ? Colors.white : Colors.blueGrey.shade900,
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.local_movies,
                    size: 100.0, color: !isDark ? Colors.blue : Colors.white),
                ListTile(
                  leading: Icon(Icons.local_movies, size: 0),
                  title: Text('${instituteId} Bus Service',
                      style: TextStyle(
                        fontSize: 30.0,
                      )),
                  subtitle: Text(
                      userTicketCount > 0
                          ? 'You have ${userTicketCount} credits left.'
                          : 'You have ${userTicketCount} credits left.Please click Buy More.',
                      style: TextStyle(fontSize: 18.0)),
                ),
                userTicketCount > 0
                    ? TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: isDark
                              ? Color.fromARGB(255, 197, 75, 75)
                              : Colors.red,
                          disabledForegroundColor:
                              Colors.grey.withOpacity(0.38),
                        ),
                        child: const Text('Use Credit'),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return QrGenerator('Scan to use Credit');
                              },
                            ),
                          );
                        },
                      )
                    : Text(''),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: isDark ? Colors.blueGrey : Colors.blue,
                    disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  ),
                  child: const Text('Buy More'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return QrGenerator('Scan to buy Credit');
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
