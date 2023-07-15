import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/Profile/auth_sub_pages/auth.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
List<dynamic> items = [];
int userTicketCount = 0;
int userCredit = 0;
String instituteId = '';
String notice = '';
bool isLoaded = false;
Map<String, dynamic>? userData;

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final _controllerNotice = TextEditingController();
  bool isLoading = false;
  bool isLogin = true;
  @override
  void dispose() {
    _controllerNotice.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    updateNotice();
  }

  updateNotice() async {
    getDocIds() async {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user?.email)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((document) {
          // Access the data in the document
          var data = document.data();
          instituteId = data['institute'];
          debugPrint('${instituteId}');
          // getBusNotice(instituteId);
          // Do something with the data
        });
      });
      try {
        // final response = await http.get(
        //   Uri.parse(
        //       "https://busy-jay-earrings.cyclic.app/notice/${instituteId}"),
        // );
        // final body = response.body;
        // final json = jsonDecode(body);
        // print(json);
        // debugPrint(_controllerNotice.text);

        setState(() {
          isLoading = true;
        });

        final response = await http.get(
          Uri.parse(
              "https://busy-jay-earrings.cyclic.app/notice/${instituteId}"),
        );
        final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          _controllerNotice.text = json['results'][0]['notice'];
          isLoading = false;
        });
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Network Error'),
                  content: Text(
                      'Could not conect to server, Please try again later'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    )
                  ],
                ));
        print(e);
      }
    }

    getDocIds();
  }

  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // ignore: unused_element
    Widget _entryField(
        String title, TextEditingController controller, bool password) {
      return TextField(
        obscureText: password,
        // enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(),
          ),
        ),
      );
    }

    // ignore: unused_element
    Widget _submitButton() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          textStyle: const TextStyle(fontSize: 20),
          backgroundColor: themeProvider.isDark ? Colors.blue[700] : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: () async {
          setState(() {
            isLoading = !isLoading;
          });
          await updateNotice();
          setState(() {
            isLoading = !isLoading;
          });
        },
        child: Text(!isLoading ? 'Get updates' : 'Updating '),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = !isLoading;
          });
          await updateNotice();
          setState(() {
            isLoading = !isLoading;
          });
        },
        child: Icon(!isLoading ? Icons.update : Icons.refresh),
      ),
      appBar: AppBar(
        title: const Text('Notice'),
        automaticallyImplyLeading: true,
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: themeProvider.isDark
                      ? Color.fromARGB(255, 25, 87, 169)
                      : Color.fromARGB(255, 26, 107, 247),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Notice',
                      style: TextStyle(
                        fontSize: 30,
                        color: themeProvider.isDark
                            ? Colors.white
                            : Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            themeProvider.isDark
                                ? Color.fromARGB(255, 7, 15, 35)
                                : Color.fromARGB(255, 12, 108, 203),
                            themeProvider.isDark
                                ? Color.fromARGB(255, 14, 44, 81)
                                : Color.fromARGB(255, 64, 133, 201),
                            themeProvider.isDark
                                ? Color.fromARGB(255, 11, 64, 130)
                                : Color.fromARGB(255, 78, 134, 190)
                          ])
                      // color: themeProvider.isDark ? Color(0xFFFB8580) : Color(0xFFFB8580),
                      ),
                  child: Center(
                    child: ListTile(
                      title: Center(
                        child: Text(
                            !isLoading ? _controllerNotice.text : "Updating",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                      // subtitle: Text('Share Location',
                      //     style: TextStyle(
                      //         fontSize: 15,
                      //         // fontWeight: FontWeight.bold,
                      //         color: Color.fromARGB(
                      //             255, 255, 255, 255))),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
