import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ushuttlev1/Ticket/ticket_subpages/ticketView.dart';
import 'package:ushuttlev1/Profile/auth_sub_pages/auth.dart';
import 'package:ushuttlev1/Ticket/ticket_subpages/qrGenerator.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
List<dynamic> items = [];
int userTicketCount = 0;
String instituteId = '';
bool isLoaded = false;
Map<String, dynamic>? userData;

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});
  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user?.email)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        document.reference.snapshots().listen((snapshot) {
          if (mounted) {
            // print(snapshot.data());

            setState(() {
              userData = snapshot.data();
              // print(userData!["ticketArray"][0]);
              // userTicketCount = snapshot.data()!['credit'];
              userTicketCount = (userData!["ticketArray"]).length;
              isLoaded = true;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // mounted ? fetchUserData() : null;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: bodyWidget(themeProvider),
    );
  }

  Padding bodyWidget(ThemeProvider themeProvider) {
    if (isLoaded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
        Text(
          // 'You have $userTicketCount credits',
          'Available Rides',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: !isDark ? Colors.black : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: ticketCard(),
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return QrGenerator('Scan to buy Card');
                  },
                ),
              );
            },
            child: Text(
              'Buy Package',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: isDark ? Colors.blueGrey : Colors.blue,
            ),
          ),
        ),
        bottomPanel(isDark: isDark),
      ],
    );
  }
}

class ticketCard extends StatelessWidget {
  const ticketCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          // child: Row(
          //   children: [
          //     userTicketCount > 0
          //         ? TicketView(userData!["ticketArray"][0]
          //             // isDark: isDark,
          //             )
          //         : Text('No Rides Available'),
          //     userTicketCount > 0
          //         ? TicketView(userData!["ticketArray"][1]
          //             // isDark: isDark,
          //             )
          //         : Text('No Rides Available'),
          //     // TicketView(userData
          //     //     // isDark: isDark,
          //     //     ),
          //   ],
          // ),

          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return QrGenerator('Scan to use Card');
                      },
                    ),
                  );
                },
                child: TicketView(userData!['ticketArray']),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class bottomPanel extends StatelessWidget {
  const bottomPanel({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      height: 350,
      // width: MediaQuery.of(context).size.width * 0.9,
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
            Icon(Icons.credit_card,
                size: 100.0, color: !isDark ? Colors.blue : Colors.white),
            ListTile(
              // leading: Icon(Icons.money, size: 0),
              title: Center(
                child: Text('${instituteId} Bus Service',
                    style: TextStyle(
                      fontSize: 30.0,
                    )),
              ),
              subtitle: Center(
                child: Text(
                    userCredit > 0
                        ? 'You have ${userCredit} credits.'
                        : 'You have no subscription. Please Buy More.',
                    style: TextStyle(fontSize: 18.0)),
              ),
            ),
            userCredit > 0
                ? TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: isDark
                          ? Color.fromARGB(255, 197, 75, 75)
                          : Colors.red,
                      disabledForegroundColor: Colors.grey.withOpacity(0.38),
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
                      return QrGenerator('Scan to buy credits');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}