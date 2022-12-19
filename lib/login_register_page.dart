import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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

  Widget _title() {
    return const Text(
      'Ushuttle',
      style: TextStyle(
        color: Colors.white,
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
          borderRadius: BorderRadius.circular(50.0),
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
          : (isLoading ? 'signing up' : 'Sign up')),
    );
  }

  Widget _loginOrRegistrationButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register instead' : 'Login instead'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
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
            _entryField('Email', _controllerEmail, false),
            const SizedBox(height: 16),
            // _entryField('Password', _controllerPassword),
            _entryField('Password', _controllerPassword, true),
            const SizedBox(height: 16),
            _errorMessage(),
            const SizedBox(height: 16),
            _submitButton(),
            const SizedBox(height: 16),
            _loginOrRegistrationButton(),
          ],
        ),
      ),
    );
  }
}
