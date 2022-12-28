import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/admin_pages/admin_subpages/get_admin_details.dart';
import 'package:ushuttlev1/authentication_pages/auth.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});
  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final User? user = Auth().currentUser;
  List<String> docIds = [];
  Future getDocIds() async {
    await FirebaseFirestore.instance
        .collection('admin')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (snapshot) => snapshot.docs.forEach(
            (document) {
              // print(document.reference);
              docIds.add(document.reference.id);
            },
          ),
        );
  }

  Widget _listview() {
    return FutureBuilder(
      future: getDocIds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: ListView.builder(
              itemCount: docIds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GetAdminDetails(documentId: docIds[index]),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _userUid() {
    return Text(user?.email ?? 'user email');
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Ushuttle Admin'),
          automaticallyImplyLeading: true,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         setState(() {
          //           themeProvider.toggleTheme();
          //         });
          //       },
          //       icon: Icon(!themeProvider.isDark
          //           ? Icons.sunny
          //           : Icons.nightlight_round_outlined))
          // ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          // padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 32),
              _listview(),
              // _userUid(),
              // const SizedBox(height: 16),
              // _signOutButton(),
            ],
          ),
        ));
  }
}
