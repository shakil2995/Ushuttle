import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Container(
          //   margin: const EdgeInsets.all(10.0),
          //   padding: const EdgeInsets.all(10.0),
          //   color: Colors.blueGrey,
          //   width: double.infinity,
          //   child: const Center(
          //     child: Text('Map', style: TextStyle(color: Colors.white)),
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.all(10.0),
          //   padding: const EdgeInsets.all(10.0),
          //   color: Colors.blueGrey,
          //   width: double.infinity,
          //   child: const Center(
          //     child: Text('This is a text widget',
          //         style: TextStyle(color: Colors.white)),
          //   ),
          // ),
          Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1uENsfHX_t2wf1PJ9YL2jw8XkWV7UXK7uiuT9WDHhlZbZthwUVQVjz1kwkCZp2njRQN4&usqp=CAU')
        ],
      )),
    );
  }
}
