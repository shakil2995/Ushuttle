import 'package:flutter/material.dart';
// import 'package:ushuttlev1/live_map_page_old.dart';
import 'package:ushuttlev1/subPages/fare_page.dart';
import 'package:ushuttlev1/subPages/notice_page.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheduleColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                onPressed: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const SchedulePage();
                        },
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.schedule,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      'Schedule',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                // child: const Text('Elevated Button'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: fareColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                onPressed: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const FarePage();
                        },
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.currency_exchange,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      'Fare',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                // child: const Text('Elevated Button'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: stoppageColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                onPressed: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const StoppagePage();
                        },
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.bus_alert,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      'Stoppage',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                // child: const Text('Elevated Button'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: noticeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                onPressed: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const NoticePage();
                        },
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.notifications,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      'Notice',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                // child: const Text('Elevated Button'),
              ),
            ),

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
            //               return LiveMapPage();
            //             },
            //           ),
            //         );
            //       }
            //     },
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(
            //           Icons.map,
            //           size: 50,
            //           color: Colors.white,
            //         ),
            //         Text(
            //           'LiveMaps',
            //           style: TextStyle(color: Colors.white, fontSize: 20),
            //         )
            //       ],
            //     ),
            //     // child: const Text('Elevated Button'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
