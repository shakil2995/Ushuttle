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
        children: [
          ExpandablePanel(
            header: const Text('article.title'),
            // ignore: prefer_const_constructors
            collapsed: Text(
              '',
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            expanded: const Text(
              'article.body ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
              softWrap: false,
            ),
            // tapHeaderToExpand: true,
            // hasIcon: true,
          ),
        ],
      )),
    );
  }
}



      // appBar: AppBar(
      //   title: const Text('Schedule'),
      //   automaticallyImplyLeading: true,
      // ),