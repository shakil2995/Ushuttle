import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [mirpurTobashundhara(), bashundharaToMirpur()],
      )),
    );
  }

  Container mirpurTobashundhara() {
    return Container(
      // margin: const EdgeInsets.all(10),
      // set border

      padding: const EdgeInsets.all(8.0),
      child: Container(
        //set background color to red

        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 215, 215),
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
}

Container bashundharaToMirpur() {
  return Container(
    // margin: const EdgeInsets.all(10),
    // set border

    padding: const EdgeInsets.all(8.0),
    child: Container(
      //set background color to red

      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 215, 215, 215),
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




      // appBar: AppBar(
      //   title: const Text('Schedule'),
      //   automaticallyImplyLeading: true,
      // ),