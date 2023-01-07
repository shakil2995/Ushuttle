import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ushuttlev1/authentication_pages/forgotPasswordPage.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMesssage = '';
  bool isLogin = true;
  bool isLoading = false;
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();
  final _controllerFirstName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerInstitute = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerInstitute.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    try {
      await Auth().signIn(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim());
      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMesssage = e.message;
      });
    }
    Navigator.of(context).pop();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim(),
        );
        addUserDetails();
        // Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMesssage = e.message;
        });
      }
    }
  }

  bool passwordConfirmed() {
    return _controllerPassword.text.trim() ==
            _controllerConfirmPassword.text.trim()
        ? true
        : false;
  }

  Future addUserDetails() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'firstName': _controllerFirstName.text.trim(),
        'lastName': _controllerLastName.text.trim(),
        'institute': _controllerInstitute.text.trim(),
        'email': _controllerEmail.text.trim(),
        'ticket': 0,
        'credit': 0,
      });
      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      setState(() {
        errorMesssage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Widget _header() {
      return Text(
        isLogin ? 'Welcome back !!' : 'Hello There !!',
        // style: const TextStyle(
        //   // color: Colors.white,
        //   fontSize: 44,
        //   fontWeight: FontWeight.bold,
        // ),

        style: GoogleFonts.bebasNeue(
          // color: Colors.white,
          fontSize: 36,
          // fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget _subText() {
      return Text(
        isLogin
            ? 'Please login to your account.'
            : 'Register below with your details.',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
      // 'Welcome back, please login to your account.',
    }

    Widget _icon() {
      return const Icon(
        Icons.directions_bus,
        size: 80,
        color: Color.fromARGB(255, 38, 38, 38),
      );
    }

    // Widget _title() {
    //   return const Text(
    //     'Ushuttle',
    //     style: TextStyle(
    //       // color: Colors.white,
    //       fontSize: 24,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   );
    // }

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
          backgroundColor: themeProvider.isDark ? Colors.blue[700] : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: () async {
          setState(() {
            isLoading = !isLoading;
          });
          if (isLogin) {
            await signIn();
          } else {
            await signUp();
          }
          setState(() {
            isLoading = false;
          });
        },
        child: Text(isLogin
            ? (isLoading ? 'signing in' : 'Sign In')
            : (isLoading ? 'Registering' : 'Register')),
      );
    }

    Widget _loginOrRegistrationButton() {
      return TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            // backgroundColor: Colors.green,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin ? 'Register instead ?' : 'Login instead ?',
            style: const TextStyle(color: Colors.white),
          ));
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
          image: DecorationImage(
            image: !themeProvider.isDark
                ? AssetImage("assets/images/2.jpg")
                : AssetImage("assets/images/2dd.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 16),
              _header(),
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

              !isLogin
                  ? _entryField('Institute', _controllerInstitute, false)
                  : const SizedBox(height: 0),
              const SizedBox(height: 10),

              _entryField('Email', _controllerEmail, false),
              const SizedBox(height: 10),
              // _entryField('Password', _controllerPassword),
              _entryField('Password', _controllerPassword, true),
              const SizedBox(height: 10),
              !isLogin
                  ? _entryField(
                      'Confirm Password', _controllerConfirmPassword, true)
                  : const SizedBox(height: 0),
              // const SizedBox(height: 10),

              isLogin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_forgotPassword()],
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 0),
              _errorMessage(),
              const SizedBox(height: 0),
              _submitButton(),
              const SizedBox(height: 10),
              _loginOrRegistrationButton(),
            ],
          ),
        ),
      ),
    );
  }
}
