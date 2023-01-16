import 'package:flutter/material.dart';
import 'package:ushuttlev1/client_home.dart';
import 'package:ushuttlev1/admin_pages/admin_home_page.dart';
import 'auth.dart';
import 'login_register_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.uid == "EMchEVdVEzYTf9OcQpqleJLTxH12") {
              // debugPrint(snapshot.data!.uid);
              return const AdminLandingPage();
            } else {
              return const RootPage();
            }
          } else {
            return const LoginPage();
          }
        });
  }
}
