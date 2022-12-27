import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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

  final _controllerEmail = TextEditingController();
  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Success'),
                content:
                    const Text('Password reset link sent ! Check your email'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  )
                ],
              ));
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(e.message.toString()),
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Enter your email to reset your password',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              _entryField('Email', _controllerEmail, false),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                  onPressed: () async {
                    await resetPassword(_controllerEmail.text);
                    // Navigator.pop(context);
                  },
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
