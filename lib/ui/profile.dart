import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final user;
  Profile(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Current user information', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10.0),
              Text('User name: ${user.name}'),
              Text('User email: ${user.email}'),
              Text('Back4App objectID: ${user.objectId}'),
              Text('Device ID: ${user.deviceId}'),
            ],
          )),
    );
  }
}
