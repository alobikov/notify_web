import 'package:flutter/material.dart';

//! debuggin version of Home screen

class Home1 extends StatelessWidget {
  const Home1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Text('This is item $index');
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(thickness: 1),
        itemCount: 50,
      ),
    );
  }
}
