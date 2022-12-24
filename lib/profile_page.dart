import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = Auth().currentUser;
  List<String> docIds = [];
  // Future getDocIds() async {
  //   QuerySnapshot result = await FirebaseFirestore.instance
  //       .collection('users')
  //       // .where('email', isEqualTo: user?.email)
  //       .get();
  //   List<DocumentSnapshot> documents = result.docs;
  //   documents.forEach((data) {
  //     print(data.id);
  //     docIds.add(data.id);
  //   });
  // }
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
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
                  title: Text(docIds[index]),
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
  // Widget _title() {
  //   return const Text(
  //     'Firebase Auth',
  //     style: TextStyle(
  //       color: Colors.white,
  //       fontSize: 24,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }

  Widget _userUid() {
    return Text(user?.email ?? 'user email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: () async {
          await Auth().signOut();
        },
        child: const Text('Sign Out'));
  }

  @override
  void initState() {
    super.initState();
    getDocIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _listview(),
          _userUid(),
          const SizedBox(height: 16),
          _signOutButton(),
        ],
      ),
    ));
  }
}
