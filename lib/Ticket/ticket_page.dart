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
int userCredit = 0;
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
              // print(userData!["credit"]);
              userCredit = snapshot.data()!['credit'];
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
      body: isLoaded
          ? bodyWidget(themeProvider)
          : Center(child: CircularProgressIndicator()),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      // 'You have $userTicketCount credits',
                      'Available Rides',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: !themeProvider.isDark
                              ? Colors.black
                              : Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),

                  subscriptionCards(context: context),
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.85,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //           builder: (BuildContext context) {
                  //             return QrGenerator('Scan to buy Card');
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     child: Text(
                  //       'Buy Package',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     style: TextButton.styleFrom(
                  //       backgroundColor: themeProvider.isDark
                  //           ? Colors.blueGrey
                  //           : Colors.blue,
                  //     ),
                  //   ),
                  // ),

// bottom container card

                  Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    height: 350,
                    // width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromARGB(255, 243, 99, 99),
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.credit_card,
                              size: 100.0,
                              color: !themeProvider.isDark
                                  ? Colors.blue
                                  : Colors.white),
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
                                      : 'You have no Credit. Please Buy More.',
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                          ),
                          userCredit > 0
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: themeProvider.isDark
                                        ? Color.fromARGB(255, 197, 75, 75)
                                        : Colors.red,
                                    disabledForegroundColor:
                                        Colors.grey.withOpacity(0.38),
                                  ),
                                  child: const Text(
                                    'Use Credit',
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return QrGenerator(
                                              'Scan to use Credit');
                                        },
                                      ),
                                    );
                                  },
                                )
                              : Text(''),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: themeProvider.isDark
                                  ? Colors.blueGrey
                                  : Colors.blue,
                              disabledForegroundColor:
                                  Colors.grey.withOpacity(0.38),
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
                  ),
                ],
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

class subscriptionCards extends StatelessWidget {
  const subscriptionCards({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
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
        ),
      ),
    );
  }
}
