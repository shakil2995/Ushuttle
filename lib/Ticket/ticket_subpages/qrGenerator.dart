import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/Profile/auth_sub_pages/auth.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
List<dynamic> items = [];
int userCredit = 0;
String userEmail = '';
String pageName = '';

/// This is the screen that you'll see when the app starts
class QrGenerator extends StatefulWidget {
  QrGenerator(String passedString) {
    pageName = passedString;
  }

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
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
          userEmail = data['email'];
          int credit = data['credit'];
          if (mounted) {
            setState(() {
              userCredit = credit;
            });
          }
        });
      });
    }

    getDocIds();
  }

  

  Widget build(BuildContext context) {
    fetchUserData();
    final themeProvider = Provider.of<ThemeProvider>(context);

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: userEmail,
            version: QrVersions.auto,
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: themeProvider.isDark
                  ? ui.Color.fromARGB(255, 255, 255, 255)
                  : ui.Color.fromARGB(255, 14, 14, 14),
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: themeProvider.isDark
                  ? ui.Color.fromARGB(255, 254, 255, 255)
                  : ui.Color.fromARGB(255, 14, 14, 14),
            ),
            
          ),
        );
      },
    );


    String messageDev = ('Show this QR code to the manager.'
        'Please wait for a few seconds.');
    return Scaffold(
      // backgroundColor: themeProvider.isDark ? Colors.white : Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('Ushuttle'),
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
      body: Material(
        // color: ui.Color.fromARGB(255, 35, 34, 34),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                      .copyWith(bottom: 40),
                  child: Text(pageName,
                      style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.isDark
                            ? ui.Color.fromARGB(255, 255, 255, 255)
                            : ui.Color.fromARGB(255, 14, 14, 14),
                      )
                      // style: Theme.of(context).textTheme.bodyText1,
                      ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 280,
                      child: qrFutureBuilder,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                      .copyWith(bottom: 40),
                  child: Text(userEmail,
                      style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.isDark
                            ? ui.Color.fromARGB(255, 255, 255, 255)
                            : ui.Color.fromARGB(255, 14, 14, 14),
                      )
                      // style: Theme.of(context).textTheme.bodyText1,
                      ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                      .copyWith(bottom: 40),
                  child: Text(messageDev,
                      style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.isDark
                            ? ui.Color.fromARGB(255, 255, 255, 255)
                            : ui.Color.fromARGB(255, 14, 14, 14),
                      )
                      // style: Theme.of(context).textTheme.bodyText1,
                      ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/images/splashRound.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
