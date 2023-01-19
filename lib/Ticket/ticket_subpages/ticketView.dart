// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushuttlev1/Ticket/ticket_page.dart';
import 'package:intl/intl.dart';
import 'package:ushuttlev1/shared_subpages/provider/theme_provider.dart';

class TicketView extends StatefulWidget {
  TicketView(List<dynamic>? userData, {super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  // get ticketNo => null;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // print(userData);
    // final credit = userData!['credit'];
    // final lastName = userData!['lastName'];
    // final ticketArray = userData!['ticketArray'];
    final allTickets = userData!['ticketArray'];
    // final allTickets = [...userData!['ticketArray']];

    final firstTicket = userData!['ticketArray'][0];
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
    // print(userData!['ticketArray']);

    // print(ticketNo);
    // return ticketWidget(
    //     themeProvider: themeProvider,
    //     busName: busName,
    //     from: from,
    //     to: to,
    //     startPoint: startPoint,
    //     fare: fare,
    //     endPoint: endPoint,
    //     buyDateString: buyDateString,
    //     isTwoWay: isTwoWay,
    //     startTime: startTime,
    //     returnTime: returnTime,
    //     seatNo: seatNo,
    //     expireDateString: expireDateString,
    //     rideRemain: rideRemain);

    return Row(
      children: [
        ...allTickets.map((ticket) {
          // print(ticket);
          // final ticketNo = ticket["ticketNo"];
          return ticketWidget(
            themeProvider: themeProvider,
            busName: ticket['busName'],
            from: ticket['from'],
            to: ticket['to'],
            startPoint: ticket['startPoint'],
            fare: ticket['fare'],
            endPoint: ticket['endPoint'],
            rideRemain: ticket['rideRemain'],
            isTwoWay: ticket['isTwoWay'],
            startTime: ticket['startTime'],
            returnTime: ticket['returnTime'],
            seatNo: ticket['seatNo'],
            expireDate: ticket['expireDate'],
            buyDateString: DateFormat("dd-MM-yy").format(
                DateTime.fromMillisecondsSinceEpoch(
                    ticket['buyDate'].seconds * 1000 +
                        ticket['buyDate'].nanoseconds ~/ 1000000)),
            expireDateString: DateFormat("dd-MM-yy").format(
                DateTime.fromMillisecondsSinceEpoch(
                    ticket['expireDate'].seconds * 1000 +
                        ticket['expireDate'].nanoseconds ~/ 1000000)),
          );
        }),
      ],
    );
  }
}

class ticketWidget extends StatelessWidget {
  const ticketWidget({
    Key? key,
    required this.themeProvider,
    required this.busName,
    required this.from,
    required this.to,
    required this.startPoint,
    required this.fare,
    required this.endPoint,
    required this.buyDateString,
    required this.isTwoWay,
    required this.startTime,
    required this.returnTime,
    required this.seatNo,
    required this.expireDateString,
    required this.rideRemain,
    required this.expireDate,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final busName;
  final from;
  final to;
  final startPoint;
  final fare;
  final endPoint;
  final String buyDateString;
  final isTwoWay;
  final startTime;
  final returnTime;
  final seatNo;
  final String expireDateString;
  final rideRemain;
  final expireDate;

  @override
  Widget build(BuildContext context) {
    Color topColor = themeProvider.isDark
        ? Color.fromARGB(255, 74, 116, 215)
        : Color.fromARGB(255, 85, 119, 198);
    Color midColor = themeProvider.isDark
        ? Color.fromARGB(255, 243, 99, 99)
        : Color.fromARGB(255, 255, 95, 95);
    Color bottomColor = themeProvider.isDark
        ? Color.fromARGB(255, 243, 99, 99)
        : Color.fromARGB(255, 255, 95, 95);

    return true
        ? SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            height: 220,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: topColor,
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
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: List.generate(
                                            (54 / 6).floor(),
                                            (index) => Text(" - ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ))));
                                  },
                                ),
                              ),
                              Center(
                                child: Transform.rotate(
                                  angle: 0,
                                  child: Icon(
                                    Icons.directions_bus,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]),
                            ticketThickBorder(),
                            Expanded(child: Container()),
                            Text(
                              to,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
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
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "Fare $fare",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  endPoint,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ])
                      ],
                    ),
                  ),
                  Container(
                    color: midColor,
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
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                      color: bottomColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(21),
                          bottomRight: Radius.circular(21)),
                    ),
                    padding: const EdgeInsets.only(
                        left: 16, top: 10, bottom: 16, right: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Buy Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    buyDateString,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    isTwoWay ? "Two Way" : "One Way",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    startTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    returnTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Seat no $seatNo",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Expire Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    expireDateString,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "$rideRemain rides left",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ]),
                  )
                ],
              ),
            ),
          )
        : Text('Date over');
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
