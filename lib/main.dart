import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ushuttlev1/widget_tree.dart';
import 'firebase_options.dart';
import 'globals.dart' as globals;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  setTheme() {
    if (globals.isDarkMode) {
      return ThemeData(
        brightness: Brightness.dark,
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: setTheme(),
      home: const WidgetTree(),
    );
  }
}
