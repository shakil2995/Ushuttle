import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ushuttlev1/shared_subpages/about_ushuttle.dart';
import 'package:ushuttlev1/Ticket/ticket_page.dart';
import 'package:ushuttlev1/Profile/auth_sub_pages/auth.dart';

class GetUserDetails extends StatelessWidget {
  // const UserDetails({super.key});
  final String documentId;
  const GetUserDetails({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                // border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/images/splash.jpg')),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${data['firstName'].toString().toUpperCase()} ${data['lastName'].toString().toUpperCase()}',
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Email: ${data['email']}'),
                  const SizedBox(height: 4),
                  Text('Institution: ${data['institute']}'),
                  SizedBox(height: 16),
                  SizedBox(
                    // height: 4,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.amber,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Edit Profile')),
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                  const SizedBox(height: 20),
                  menuWidget(
                    title: 'Settings',
                    onPress: () {},
                    icon: Icons.settings,
                    // textColor: Colors.white,
                  ),
                  menuWidget(
                    title: 'Billing Details',
                    onPress: () {},
                    icon: Icons.wallet,
                    // textColor: Colors.white,
                  ),
                  menuWidget(
                    title: 'My Tickets',
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return TicketPage();
                          },
                        ),
                      );
                    },
                    icon: Icons.local_movies,
                    // textColor: Colors.white,
                  ),
                  Divider(),
                  menuWidget(
                    title: 'About Us',
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const InfoPage();
                          },
                        ),
                      );
                    },
                    icon: Icons.info,
                    // textColor: Colors.white,
                  ),
                  menuWidget(
                    title: 'Logout',
                    onPress: () async {
                      await Auth().signOut();
                    },
                    icon: Icons.logout,
                    textColor: Colors.red,
                  ),
                ],
              ),
            );
          }
          return const Text('');
        }));
  }
}

class menuWidget extends StatelessWidget {
  const menuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        // tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 14, 14, 14).withOpacity(0.1),
            border:
                Border.all(color: Color.fromARGB(255, 248, 248, 248), width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(icon),
        ),
        title: Text(title,
            style:
                Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
        // subtitle: Text(data['firstName']),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  // border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(Icons.keyboard_arrow_right,
                    size: 18.0, color: Colors.grey),
              )
            : null,
      ),
    );
  }
}
