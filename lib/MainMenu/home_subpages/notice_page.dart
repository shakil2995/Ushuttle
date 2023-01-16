import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

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
    try {
      final response = await http.get(
        Uri.parse("https://busy-jay-earrings.cyclic.app/notice"),
      );
      final body = response.body;
      final json = jsonDecode(body);
      // print(json);
      setState(() {
        _controllerNotice.text = json['results'][0]['notice'];
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Network Error'),
                content:
                    Text('Could not conect to server, Please try again later'),
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
        child: Text(isLoading ? 'Updating' : 'See updates '),
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
            isLoading = false;
          });
        },
        child: Icon(isLoading ? Icons.update : Icons.refresh),
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
            const SizedBox(height: 20),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: themeProvider.isDark
                    ? Color.fromARGB(255, 77, 77, 77)
                    : Color.fromARGB(159, 163, 170, 184),
              ),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              // color: Color.fromARGB(255, 255, 106, 106),
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(isLoading ? 'Updating' : 'Notice',
                          style: TextStyle(
                            fontSize: 30,
                            color: themeProvider.isDark
                                ? Colors.white
                                : Color.fromARGB(255, 5, 5, 5),
                          )),
                    ),
                    Text(_controllerNotice.text,
                        style: TextStyle(
                          fontSize: 20,
                          color: themeProvider.isDark
                              ? Colors.white
                              : Color.fromARGB(255, 5, 5, 5),
                        )),
                  ],
                ),
              ),
            ),

            // _submitButton(),
          ],
        ),
      )),
    );
  }
}
