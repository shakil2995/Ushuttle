import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

class StoppagePage extends StatefulWidget {
  const StoppagePage({super.key});

  @override
  State<StoppagePage> createState() => _StoppagePageState();
}

class _StoppagePageState extends State<StoppagePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stoppage'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  themeProvider.toggleTheme();
                });
              },
              icon: Icon(!themeProvider.isDark
                  ? Icons.sunny
                  : Icons.nightlight_round_outlined))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          mirpurTobashundhara(themeProvider.isDark),
          bashundharaToMirpur(themeProvider.isDark)
        ],
      )),
    );
  }
}

Container mirpurTobashundhara(bool isDark) {
  return Container(
    // margin: const EdgeInsets.all(10),
    // set border

    padding: const EdgeInsets.all(8.0),
    child: Container(
      //set background color to red

      decoration: BoxDecoration(
        color: isDark
            ? Color.fromARGB(255, 87, 87, 87)
            : Color.fromARGB(255, 207, 207, 207),
        borderRadius: BorderRadius.circular(5),
      ),

      child: ExpandablePanel(

          // add border

          header: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Mirpur to Bashundhara',
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          collapsed: Text(
            '',
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
          expanded: Container(
              padding: const EdgeInsets.all(15),
              child: Table(
                // rounder border
                border: TableBorder.all(
                  color: Colors.black45,
                  style: BorderStyle.solid,
                  width: 1,
                  borderRadius: BorderRadius.circular(4),
                ),
                children: const [
                  TableRow(children: [
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "From",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Time",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Day",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Fare",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                  ]),
                  TableRow(
                    children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Mirpur 1", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "08.00 AM", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Daily", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "50 Tk", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                    ],
                  ),
                ],
              ))

          // tapHeaderToExpand: true,
          // hasIcon: true,
          ),
    ),
  );
}

Container bashundharaToMirpur(bool isDark) {
  return Container(
    // margin: const EdgeInsets.all(10),
    // set border

    padding: const EdgeInsets.all(8.0),
    child: Container(
      //set background color to red

      decoration: BoxDecoration(
        color: isDark
            ? Color.fromARGB(255, 87, 87, 87)
            : Color.fromARGB(255, 207, 207, 207),
        borderRadius: BorderRadius.circular(5),
      ),

      child: ExpandablePanel(

          // add border

          header: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Bashundhara to Mirpur',
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          collapsed: Text(
            '',
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
          expanded: Container(
              padding: const EdgeInsets.all(15),
              child: Table(
                // rounder border
                border: TableBorder.all(
                  color: Colors.black45,
                  style: BorderStyle.solid,
                  width: 1,
                  borderRadius: BorderRadius.circular(4),
                ),
                children: const [
                  TableRow(children: [
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "From",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Time",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Day",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Fare",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    )),
                  ]),
                  TableRow(
                    children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Mirpur 1", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "08.00 AM", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Daily", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "50 Tk", textAlign: TextAlign.center,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      )),
                    ],
                  ),
                ],
              ))

          // tapHeaderToExpand: true,
          // hasIcon: true,
          ),
    ),
  );
}
