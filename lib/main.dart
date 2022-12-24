import 'package:flutter/material.dart';
// import 'package:ushuttlev1/home_page.dart';
// import 'package:ushuttlev1/info_page.dart';
// import 'package:ushuttlev1/live_map_page_old.dart';
// import 'package:ushuttlev1/map_page.dart';
// import 'package:ushuttlev1/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ushuttlev1/widget_tree.dart';
// import 'package:ushuttlev1/subPages/live_map_page.dart';
import 'firebase_options.dart';
// import 'live_location_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.pink),
      ),
      // home: const RootPage(),
      home: const WidgetTree(),
    );
  }
}
