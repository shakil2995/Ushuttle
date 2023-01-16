import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class UshuttleHelpDesk extends StatelessWidget {
  const UshuttleHelpDesk({super.key});
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => _callNumber('999'),
          child: Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.7,
            // width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.white,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFD8080),
                      Color(0xFFFB8580),
                      Color(0xFFFBD079)
                    ])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 244, 244, 244),
                    child: const Icon(
                      Icons.local_police,
                      size: 50,
                      color: Color.fromARGB(255, 77, 77, 77),
                    ),
                  ),
                  Text('Ushuttle Helpdesk',
                      style: TextStyle(
                          color: Color.fromARGB(255, 247, 245, 245),
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold)),
                  Text('In case of emergencies call',
                      style: TextStyle(
                          color: Color.fromARGB(255, 247, 245, 245),
                          overflow: TextOverflow.ellipsis,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.bold)),
                  Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('9-9-9',
                          style: TextStyle(
                              color: Colors.red,
                              overflow: TextOverflow.ellipsis,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
