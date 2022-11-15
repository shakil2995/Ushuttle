import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
            child: SizedBox(
              child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1uENsfHX_t2wf1PJ9YL2jw8XkWV7UXK7uiuT9WDHhlZbZthwUVQVjz1kwkCZp2njRQN4&usqp=CAU'),
            ),
          ),
          const Text(
            'Coming Soon',
            style: TextStyle(fontSize: 50),
          ),
        ],
      )),
    );
  }
}
