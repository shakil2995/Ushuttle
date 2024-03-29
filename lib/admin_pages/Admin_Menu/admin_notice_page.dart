import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/Profile/auth_sub_pages/auth.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

final User? user = Auth().currentUser;
String instituteId = '';

class AdminNoticePage extends StatefulWidget {
  const AdminNoticePage({super.key});

  @override
  State<AdminNoticePage> createState() => _AdminNoticePageState();
}

class _AdminNoticePageState extends State<AdminNoticePage> {
  // void initState() {
  //   super.initState();
  //   getDocIds();
  // }

  final _controllerNotice = TextEditingController();
  bool isLoading = false;
  bool isLogin = true;
  @override
  void dispose() {
    _controllerNotice.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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

    updateNotice() async {
      setData() async {
        try {
          print("i id " + instituteId);
          final response = await http.post(
            Uri.parse(
                "https://busy-jay-earrings.cyclic.app/notice/${instituteId}?notice=${_controllerNotice.text}"),
          );
          final body = response.body;
          final json = jsonDecode(body);
          print(json);
          debugPrint(_controllerNotice.text);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Success'),
                    content: Text('Notice Updated'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  ));
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

      getDocIds() async {
        await FirebaseFirestore.instance
            .collection('admin')
            .where('email', isEqualTo: user?.email)
            .get()
            .then((snapshot) {
          snapshot.docs.forEach((document) {
            // Access the data in the document
            var data = document.data();

            setState(() {
              instituteId = data['institute'];
              debugPrint("data +" + instituteId);
            });
            setData();
          });
        });
      }

      getDocIds();
    }

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
            isLoading = false;
          });
        },
        child: Text(isLoading ? 'Updating' : 'Update'),
      );
    }

    return Scaffold(
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
          children: [
            const SizedBox(height: 20),
            const Text(
              'Notice',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            _entryField('Notice', _controllerNotice, false),
            const SizedBox(height: 20),
            _submitButton(),
            const SizedBox(height: 20),
            // ExpandablePanel(
            //   header: const Text('Notice'),
            //   collapsed: const Text('Notice text'),
            //   expanded: const Text(''),
            // ),
          ],
        ),
      )),
    );
  }
}
