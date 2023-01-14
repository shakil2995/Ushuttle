import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/provider/theme_provider.dart';

class SafeHome extends StatelessWidget {
  const SafeHome({super.key});
  showModelIsSafeHome(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  // topLeft: Radius.circular(20),
                  // topRight: Radius.circular(20),
                  ),
            ),
            child: Center(
              child: Text('This feature is under  development',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0))),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () => {
        showModelIsSafeHome(context),
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    !themeProvider.isDark
                        ? Color.fromARGB(255, 15, 126, 236)
                        : Color.fromARGB(255, 15, 126, 236),
                    !themeProvider.isDark
                        ? Color.fromARGB(255, 40, 157, 224)
                        : Color.fromARGB(255, 73, 149, 225),
                    !themeProvider.isDark
                        ? Color.fromARGB(255, 117, 200, 245)
                        : Color.fromARGB(255, 118, 171, 224)
                  ])
              // color: themeProvider.isDark ? Color(0xFFFB8580) : Color(0xFFFB8580),
              ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Safe Home',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255))),
                      subtitle: Text('Share Location',
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255))),
                    )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/trackMe.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
