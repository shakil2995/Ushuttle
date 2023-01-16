import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool isLoading = false;
  bool isLogin = true;
  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contat Us'),
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text("Get in touch", style: TextStyle(fontSize: 20)),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your name",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your message",
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // submit the contact form
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
