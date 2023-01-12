// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ushuttlev1/MainMenu/ticket_subpages/ticket_page.dart';
import 'package:intl/intl.dart';

class TicketView extends StatefulWidget {
  TicketView(Map<String, dynamic>? userData, {super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  @override
  Widget build(BuildContext context) {
    // print(userData);
    final credit = userData!['credit'];
    final lastName = userData!['lastName'];
    final ticketArray = userData!['ticketArray'];
    final firstTicket = ticketArray[0];
    final startPoint = firstTicket['startPoint'];
    final fare = firstTicket['fare'];
    final to = firstTicket['to'];
    final rideRemain = firstTicket['rideRemain'];
    final seatNo = firstTicket['seatNo'];
    final isTwoWay = firstTicket['isTwoWay'];
    final returnTime = firstTicket['returnTime'];
    final endPoint = firstTicket['endPoint'];
    final from = firstTicket['from'];
    final startTime = firstTicket['startTime'];
    final busName = firstTicket['busName'];
    // final ticket = userData!['ticket'];
    // final institute = userData!['institute'];
    // final email = userData!['email'];
    // final firstName = userData!['firstName'];

    final buyDate = DateTime.fromMillisecondsSinceEpoch(
        firstTicket['buyDate'].seconds * 1000 +
            firstTicket['buyDate'].nanoseconds ~/ 1000000);
    final expireDate = DateTime.fromMillisecondsSinceEpoch(
        firstTicket['expireDate'].seconds * 1000 +
            firstTicket['expireDate'].nanoseconds ~/ 1000000);
    final buyDateString = DateFormat("dd-MM-yy").format(buyDate);
    final expireDateString = DateFormat("dd-MM-yy").format(expireDate);

    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      height: 220,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(busName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
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
                              // print(constraints.constrainWidth());
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
                          "Fare $fare",
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
                          "Buy Date",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          buyDateString,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          isTwoWay ? "Two Way" : "One Way",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          startTime,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          returnTime,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Seat no $seatNo",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Expire Date",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          expireDateString,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "$rideRemain rides left",
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
