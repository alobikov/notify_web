import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:web_notify/redux/actions/auth_actions.dart';
import 'package:web_notify/redux/app_state.dart';
import '../main.dart';
import 'profile.dart';

class AppDrawer extends StatefulWidget {
  final user;
 
  AppDrawer(this.user);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
   
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // duration: Duration(milliseconds: 600),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Sign out'),
            onTap: () async {
              store.dispatch(SignoutAction());
              Navigator.pop(context);
              // Navigator.popAndPushNamed(context, '/wrapper');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(widget.user)));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('About'),
            onTap: () {
              _about();
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Close'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _about() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(CURRENT_BUILD),
                Text(CURRENT_RELEASE),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close',
                  style: TextStyle(color: Colors.brown[600], fontSize: 18.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
