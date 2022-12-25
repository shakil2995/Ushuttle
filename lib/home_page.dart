import 'package:flutter/material.dart';
// import 'package:ushuttlev1/live_map_page_old.dart';
import 'package:ushuttlev1/subPages/fare_page.dart';
import 'package:ushuttlev1/subPages/notice_page.dart';
import 'package:ushuttlev1/subPages/rest_api_test.dart';
import 'package:ushuttlev1/subPages/schedule_page.dart';
import 'package:ushuttlev1/subPages/stoppage_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Color scheduleColor = Colors.red;
Color fareColor = Colors.blue;
Color stoppageColor = Colors.green;
Color noticeColor = Colors.pink;
Color aboutColor = Colors.purple;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Grid')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: [
            buttonWidget(
              title: 'Schedule',
              icon: Icons.schedule,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const SchedulePage();
                    },
                  ),
                );
              },
              backgroundColor: scheduleColor,
            ),
            buttonWidget(
              title: 'Fare',
              icon: Icons.currency_exchange,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const FarePage();
                    },
                  ),
                );
              },
              backgroundColor: fareColor,
            ),
            buttonWidget(
              title: 'Stoppage',
              icon: Icons.bus_alert,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const StoppagePage();
                    },
                  ),
                );
              },
              backgroundColor: stoppageColor,
            ),
            buttonWidget(
              title: 'Notice',
              icon: Icons.notifications,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const NoticePage();
                    },
                  ),
                );
              },
              backgroundColor: noticeColor,
            ),
          ],
        ),
      ),
    );
  }
}

class buttonWidget extends StatelessWidget {
  const buttonWidget(
      {Key? key,
      required this.title,
      required this.icon,
      this.onPress,
      this.textColor,
      this.backgroundColor})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback? onPress;
  final Color? textColor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        onPressed: onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              // Icons.schedule,
              size: 50,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
        // child: const Text('Elevated Button'),
      ),
    );
  }
}


            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: fareColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12), // <-- Radius
            //       ),
            //     ),
            //     onPressed: () {
            //       {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (BuildContext context) {
            //               return const FarePage();
            //             },
            //           ),
            //         );
            //       }
            //     },
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(
            //           Icons.currency_exchange,
            //           size: 50,
            //           color: Colors.white,
            //         ),
            //         Text(
            //           'Fare',
            //           style: TextStyle(color: Colors.white, fontSize: 20),
            //         )
            //       ],
            //     ),
            //     // child: const Text('Elevated Button'),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: stoppageColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12), // <-- Radius
            //       ),
            //     ),
            //     onPressed: () {
            //       {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (BuildContext context) {
            //               return const StoppagePage();
            //             },
            //           ),
            //         );
            //       }
            //     },
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(
            //           Icons.bus_alert,
            //           size: 50,
            //           color: Colors.white,
            //         ),
            //         Text(
            //           'Stoppage',
            //           style: TextStyle(color: Colors.white, fontSize: 20),
            //         )
            //       ],
            //     ),
            //     // child: const Text('Elevated Button'),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: noticeColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12), // <-- Radius
            //       ),
            //     ),
            //     onPressed: () {
            //       {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (BuildContext context) {
            //               return const NoticePage();
            //             },
            //           ),
            //         );
            //       }
            //     },
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(
            //           Icons.notifications,
            //           size: 50,
            //           color: Colors.white,
            //         ),
            //         Text(
            //           'Notice',
            //           style: TextStyle(color: Colors.white, fontSize: 20),
            //         )
            //       ],
            //     ),
            //     // child: const Text('Elevated Button'),
            //   ),
            // ),

//  live map
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: aboutColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12), // <-- Radius
            //       ),
            //     ),
            //     onPressed: () {
            //       {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (BuildContext context) {
            //               return const RestApiTest();
            //             },
            //           ),
            //         );
            //       }
            //     },
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(
            //           Icons.api,
            //           size: 50,
            //           color: Colors.white,
            //         ),
            //         Text(
            //           'Api Location',
            //           style: TextStyle(color: Colors.white, fontSize: 20),
            //         )
            //       ],
            //     ),
            //     // child: const Text('Elevated Button'),
            //   ),
            // ),