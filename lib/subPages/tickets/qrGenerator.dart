import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/auth.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
List<dynamic> items = [];
int userTicketCount = 0;
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
          int ticket = data['ticket'];
          if (mounted) {
            setState(() {
              userTicketCount = ticket;
            });
          }
        });
      });
    }

    getDocIds();
  }

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
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
                  ? ui.Color.fromARGB(255, 18, 208, 255)
                  : ui.Color.fromARGB(255, 14, 14, 14),
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: themeProvider.isDark
                  ? ui.Color.fromARGB(255, 18, 208, 255)
                  : ui.Color.fromARGB(255, 14, 14, 14),
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.fromRadius(30),
            ),
          ),
        );
      },
    );

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
          // setState(() {
          //   isLoading = !isLoading;
          // });
          // if (isLogin) {
          //   await signIn();
          // } else {
          //   await signUp();
          // }
          // setState(() {
          //   isLoading = false;
          // });
        },
        child: Text('Generate QR'),
      );
    }

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
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                //   child: _entryField('Email', _controllerEmail, false),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                //   child: _submitButton(),
                // ),
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
