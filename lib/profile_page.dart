import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ushuttlev1/subPages/get_user_details.dart';
import './auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = Auth().currentUser;
  List<String> docIds = [];
  Future getDocIds() async {
    await FirebaseFirestore.instance
        .collection('users')
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
                  title: GetUserDetails(documentId: docIds[index]),
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

  // Widget _userUid() {
  //   return Text(user?.email ?? 'user email');
  // }

  // Widget _signOutButton() {
  //   return ElevatedButton(
  //       onPressed: () async {
  //         await Auth().signOut();
  //       },
  //       child: const Text('Sign Out'));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // const SizedBox(height: 16),
          _listview(),
          // _userUid(),
          // const SizedBox(height: 16),
          // _signOutButton(),
        ],
      ),
    ));
  }
}
