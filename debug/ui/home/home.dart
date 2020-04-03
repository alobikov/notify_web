import 'package:flutter/material.dart';
import 'package:web_notify/ui/drawer.dart';
import 'msg_pan.dart';
import 'address_list.dart';
import 'compose.dart';

class Home extends StatelessWidget {
  final user;
  Home(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        actions: <Widget>[],
      ),
      drawer: AppDrawer(user),
      body: SingleChildScrollView(
        child: Container(
          width: 840,
          height: 740,
          color: Colors.blue[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //! Address List Area
                height: 700,
                width: 200,
                padding: const EdgeInsets.all(1.0),
                // color: Colors.teal[100],
                child: AddressList(),
              ),
              SizedBox(width: 10.0),
              Container(
                height: 700,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      //! Message Compose Area
                      width: 590,
                      height: 200,
                      child: Container(
                        color: Colors.grey[100],
                        child: Compose(),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      //! MessageList Area
                      height: 500,
                      width: 590,
                      child: MsgPan(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
