import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class AdminNoticePage extends StatefulWidget {
  const AdminNoticePage({super.key});

  @override
  State<AdminNoticePage> createState() => _AdminNoticePageState();
}

class _AdminNoticePageState extends State<AdminNoticePage> {
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
          // if (isLogin) {
          //   await signIn();
          // } else {
          //   await signUp();
          // }
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
