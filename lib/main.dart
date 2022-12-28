import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';
import 'package:ushuttlev1/authentication_pages/widget_tree.dart';
import 'firebase_connect/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of(context);
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.theme,
          home: const WidgetTree(),
        );
      },
    );
  }
}
