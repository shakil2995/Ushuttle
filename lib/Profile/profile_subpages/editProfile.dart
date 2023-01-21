import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ushuttlev1/Profile/auth_sub_pages/forgotPasswordPage.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';
import '../auth_sub_pages/auth.dart';

List<String> docIds = [];
final User? user = Auth().currentUser;
List<dynamic> items = [];
int userTicketCount = 0;
int userCredit = 0;
String instituteId = '';
bool isLoaded = false;
Map<String, dynamic>? userData;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _LoginPageState();
}

class _LoginPageState extends State<EditProfile> {
  String? errorMesssage = '';
  bool isLogin = false;
  bool isLoading = false;
  final _controllerFirstName = TextEditingController();
  final _controllerLastName = TextEditingController();
  bool _passwordVisible = false;
  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user?.email)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        document.reference.snapshots().listen((snapshot) {
          if (mounted) {
            // print(snapshot.data());

            setState(() {
              userData = snapshot.data();
              print(userData!["credit"]);
              userCredit = snapshot.data()!['credit'];
              // userTicketCount = snapshot.data()!['credit'];
              userTicketCount = (userData!["ticketArray"]).length;
              isLoaded = true;
            });
          }
        });
      });
    });
  }

//  Firebase signup
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future updateUserDetails() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((document) {
          // Access the data in the document
          var data = document.data();
          print(data);
          final docUser =
              FirebaseFirestore.instance.collection('users').doc(document.id);
          docUser.update({
            'firstName': _controllerFirstName.text.trim(),
            'lastName': _controllerLastName.text.trim(),
          });
        });
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Success'),
                content: Text('Profile updated successfully'),
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
      print(e);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text('Woops! something went wrong! Try again later'),
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Widget _subText() {
      return Text(
        'Update your profile',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
      // 'Welcome back, please login to your account.',
    }

    Widget _entryField(
        String title, TextEditingController controller, bool password) {
      _passwordVisible = password;
      return TextField(
        obscureText: _passwordVisible,
        // enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: _passwordVisible
              ? IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
          labelText: title,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(),
          ),
        ),
      );
    }

    Widget _errorMessage() {
      return Text(
        errorMesssage ?? '',
        style: const TextStyle(color: Colors.red),
      );
    }

    Widget _forgotPassword() {
      return TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const ForgotPasswordPage();
                },
              ),
            );
          },
          child: const Text('Forgot Password ?',
              style: TextStyle(fontSize: 14, color: Colors.white)));
    }

    Widget _submitButton() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          textStyle: const TextStyle(fontSize: 20),
          backgroundColor: themeProvider.isDark
              ? Color.fromARGB(255, 41, 91, 178)
              : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: () async {
          setState(() {
            isLoading = !isLoading;
          });
          updateUserDetails();
          setState(() {
            isLoading = false;
          });
        },
        child: Text((isLoading ? 'Updating' : 'Update'),
            style: TextStyle(
                color: themeProvider.isDark
                    ? Colors.white
                    : Color.fromARGB(255, 252, 252, 252))),
      );
    }

    return Scaffold(
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeProvider.isDark
              ? Color.fromARGB(255, 40, 41, 43)
              : Colors.white,
          // image: DecorationImage(
          //   image: !themeProvider.isDark
          //       ? AssetImage("assets/images/2.jpg")
          //       : AssetImage("assets/images/2dd.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              _subText(),
              const SizedBox(height: 16),
              !isLogin
                  ? _entryField('First Name', _controllerFirstName, false)
                  : const SizedBox(height: 0),
              const SizedBox(height: 10),
              !isLogin
                  ? _entryField('Last Name', _controllerLastName, false)
                  : const SizedBox(height: 0),
              const SizedBox(height: 10),
              isLogin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_forgotPassword()],
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _errorMessage(),
              ),
              const SizedBox(height: 0),
              _submitButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
