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

// const MaterialColor customBlack = MaterialColor(
//   _customBlackPrimaryValue,
//   <int, Color>{
//     50: Color(0xFFECEFF1),
//     100: Color(0xFFCFD8DC),
//     200: Color(0xFFB0BEC5),
//     300: Color(0xFF90A4AE),
//     400: Color(0xFF78909C),
//     500: Color(_customBlackPrimaryValue),
//     600: Color(0xFF546E7A),
//     700: Color(0xFF455A64),
//     800: Color(0xFF37474F),
//     900: Color(0xFF263238),
//   },
// );
// const int _customBlackPrimaryValue = 0xFF263238;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: ColorScheme.fromSwatch(primarySwatch: customBlack)
      //       .copyWith(secondary: Colors.black),
      // ),
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        // brightness: Brightness.light,
      ),
      // home: const RootPage(),
      home: const WidgetTree(),
    );
  }
}
