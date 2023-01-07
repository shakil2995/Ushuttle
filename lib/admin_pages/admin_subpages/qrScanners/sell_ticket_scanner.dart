import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ushuttlev1/authentication_pages/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
List<dynamic> items = [];
int userCredit = 0;
int ticketPrice = 0;
String instituteId = '';
bool isLoaded = false;

void main() => runApp(const MaterialApp(home: SellQrScanner()));

class SellQrScanner extends StatefulWidget {
  const SellQrScanner({Key? key}) : super(key: key);

  @override
  State<SellQrScanner> createState() => _SellQrScannerState();
}

class _SellQrScannerState extends State<SellQrScanner> {
  final _ticketAmount = TextEditingController();

  @override
  void dispose() {
    _ticketAmount.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchBusData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qr home page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SellTicketScanner(),
            ));
          },
          child: const Text('qrView'),
        ),
      ),
    );
  }

  void fetchBusData() async {
    getDocIds() async {
      try {
        await FirebaseFirestore.instance
            .collection('admin')
            .where('email', isEqualTo: user?.email)
            .get()
            .then((snapshot) {
          snapshot.docs.forEach((document) {
            // Access the data in the document
            var data = document.data();

            print(document);
            instituteId = data['institute'];
            int price = data['price'];
            print(price);
            if (mounted) {
              setState(() {
                ticketPrice = price;
                isLoaded = true;
              });
            }
          });
        });
      } catch (e) {}
    }

    getDocIds();
  }
}

class SellTicketScanner extends StatefulWidget {
  const SellTicketScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannerState();
}

class _QrScannerState extends State<SellTicketScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void fetchBusData() async {
    getDocIds() async {
      await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: user?.email)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((document) {
          // Access the data in the document
          var data = document.data();
          // print(data);
          instituteId = data['institute'];
          int price = data['price'];
          if (mounted) {
            setState(() {
              ticketPrice = price;
              isLoaded = true;
            });
          }
        });
      });
    }

    getDocIds();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    fetchBusData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Credits'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Price: ${ticketPrice} tk');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              // await controller?.flipCamera();
                              result != null ? fetchUserData() : null;
                              print('userCredit: $userCredit');
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      // 'Add tickets to user ${describeEnum(snapshot.data!)}');
                                      'Add credit to user');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void fetchUserData() async {
    getDocIds() async {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: result!.code)
            .get()
            .then((snapshot) {
          snapshot.docs.forEach((document) {
            // Access the data in the document
            var data = document.data();
            final docUser =
                FirebaseFirestore.instance.collection('users').doc(document.id);
            docUser.update({
              'credit': FieldValue.increment(ticketPrice),
            });

            print(document);
            instituteId = data['institute'];
            int ticket = data['ticket'];
            if (mounted) {
              setState(() {
                userCredit = ticket;
                isLoaded = true;
              });
            }
          });
        });
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Success'),
                  content: result!.code != null
                      ? Text(
                          '${ticketPrice} credits added to ${result!.code}. User now has ${userCredit + ticketPrice} credits')
                      : const Text('No user found'),
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
                  title: const Text('Error'),
                  content: Text('Operation failed. Please try again later'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    )
                  ],
                ));
      }
    }

    getDocIds();
  }
}
