// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ushuttlev1/MainMenu/ticket_subpages/ticket_page.dart';

class TicketView extends StatefulWidget {
  TicketView(Map<String, dynamic>? userData, {super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  @override
  Widget build(BuildContext context) {
    // print(userData!['ticketDetails']['from']);
    final credit = userData!['credit'];
    final institute = userData!['institute'];
    final buyDate = userData!['ticketDetails']['buyDate'];
    final busName = userData!['ticketDetails']['busName'];
    final from = userData!['ticketDetails']['from'];
    final endPoint = userData!['ticketDetails']['endPoint'];
    final startPoint = userData!['ticketDetails']['startPoint'];
    final to = userData!['ticketDetails']['to'];
    final expireDate = userData!['ticketDetails']['expireDate'];
    bool isTwoWay = userData!['ticketDetails']['isTwoWay'];
    int daysRemain = userData!['ticketDetails']['daysRemain'];
    final startTime = userData!['ticketDetails']['startTime'];
    final fare = userData!['ticketDetails']['fare'];
    final returnTime = userData!['ticketDetails']['returnTime'];
    final email = userData!['email'];
    final ticket = userData!['ticket'];
    final lastName = userData!['lastName'];
    final firstName = userData!['firstName'];
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      height: 200,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF526799),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        from,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Container()),
                      ticketThickBorder(),
                      Stack(children: [
                        SizedBox(
                          // width: 200,
                          height: 24,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              print(constraints.constrainWidth());
                              return Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate((54 / 6).floor(),
                                      (index) => Text(" - ")));
                            },
                          ),
                        ),
                        Center(
                          child: Transform.rotate(
                            angle: 0,
                            child: Icon(Icons.directions_bus),
                          ),
                        )
                      ]),
                      ticketThickBorder(),
                      Expanded(child: Container()),
                      Text(
                        to,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            startPoint,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          startTime,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            endPoint,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ])
                ],
              ),
            ),
            Container(
              color: Color(0xFFF37B67),
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 248, 248),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(
                              20,
                              (index) => SizedBox(
                                    width: 5,
                                    height: 1,
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                      color: Colors.white,
                                    )),
                                  )),
                        );
                      },
                    ),
                  )),
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 248, 248),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF37B67),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(21),
                    bottomRight: Radius.circular(21)),
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 10, bottom: 16, right: 16),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          busName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          fare,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          returnTime,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          startTime,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          buyDate.toString().substring(0, 10),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          expireDate.toString().substring(0, 10),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class ticketThickBorder extends StatelessWidget {
  const ticketThickBorder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2.5, color: Colors.white)),
    );
  }
}
