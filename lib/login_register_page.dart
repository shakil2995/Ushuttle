import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    try {
      await Auth().signIn(
          email: _controllerEmail.text, password: _controllerPassword.text);
      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMesssage = e.message;
      });
    }
  }

  Future<void> signUp() async {
    try {
      await Auth().signUp(
          email: _controllerEmail.text, password: _controllerPassword.text);
      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMesssage = e.message;
      });
    }
  }

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
        fontSize: 44,
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
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
    // 'Welcome back, please login to your account.',
  }

  Widget _icon() {
    return const Icon(
      Icons.directions_bus,
      size: 100,
      color: Color.fromARGB(255, 38, 38, 38),
    );
  }

  Widget _title() {
    return const Text(
      'Ushuttle',
      style: TextStyle(
        // color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

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

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        // backgroundColor: Colors.green,
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
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register instead ?' : 'Login instead ?'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 16),
            _header(),
            const SizedBox(height: 16),
            _subText(),
            const SizedBox(height: 16),
            _entryField('Email', _controllerEmail, false),
            const SizedBox(height: 16),
            // _entryField('Password', _controllerPassword),
            _entryField('Password', _controllerPassword, true),
            const SizedBox(height: 16),
            !isLogin
                ? _entryField(
                    'Confirm Password', _controllerConfirmPassword, true)
                : const SizedBox(height: 0),
            const SizedBox(height: 0),
            _errorMessage(),
            const SizedBox(height: 0),
            _submitButton(),
            const SizedBox(height: 16),
            _loginOrRegistrationButton(),
          ],
        ),
      ),
    );
  }
}
