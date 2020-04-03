import 'package:flutter/material.dart';

import 'inbox_list.dart';

class MsgPan extends StatelessWidget {
  const MsgPan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topStart,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Inbox'),
                Tab(text: 'Outbox'),
                Tab(text: 'Chat')
              ],
            ),
            Container(
              height: 450,
              width: 600,
              child: TabBarView(
                children: [
                  InboxList(),
                  Center(child: Text("Outbox list TODO")),
                  Center(child: Text('Chat screen TODO')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
