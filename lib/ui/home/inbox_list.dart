import 'package:flutter/material.dart';
import 'package:web_notify/models/message.dart';

class InboxList extends StatefulWidget {
  @override
  _InboxListState createState() => _InboxListState();
}

class _InboxListState extends State<InboxList> {
  Messages _msg = Messages.mock(10);

  @override
  initState() {
    super.initState();
    print('MsgList initState() activated');
    // _msg.buildMockList();
    print(_msg.messages?.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: null == _msg.messages ? 0 : _msg.messages.length,
        itemBuilder: (context, index) {
          return Material( // just to make InkWell hoverColor working
            child: Container(
              margin: EdgeInsets.fromLTRB(3, 1, 5, 0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300])),
              ),
              child: InkWell(
                hoverColor: Colors.blue[100],
                onTap: () {
                  print('tapped');
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Row(
                    children: <Widget>[
                      messageTile(_msg.messages[index]),
                      // column,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget messageTile(msg) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              // align the text to the left instead of centered
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'from ' + msg.from + ' on ' + msg.timestamp,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Noto'),
                ),
                SizedBox(height: 3.0),
                Text(
                  msg.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: 'Baloo'),
                ),
              ],
            ),
          ),
          _replyButton(msg),
          _deleteButton(msg),
          Checkbox(
              value: false,
              onChanged: (data) {
                print('checked $data');
              }),
        ],
      ),
    );
  }

  Widget _deleteButton(Message msg) {
    return Container(
        child: IconButton(
            iconSize: 23.0,
            tooltip: 'Delete permanently',
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteConfirmAlert(context).then((action) {
                if (action) {
                  setState(() {
                    var id = msg.objectId;
                    print(id);
                    _msg.deleteByObjectId(id);
                    // _b4a.deleteByObjectID(id); //TODO
                  });
                }
              });
            }));
  }

  Widget _replyButton(Message msg) {
    return Container(
        child: IconButton(
            iconSize: 23.0,
            tooltip: 'Reply to sender',
            icon: Icon(Icons.reply),
            onPressed: () {
              _deleteConfirmAlert(context).then((action) {
                if (action) {
                  setState(() {
                    var id = msg.objectId;
                    print(id);
                    _msg.deleteByObjectId(id);
                    // _b4a.deleteByObjectID(id); //TODO
                  });
                }
              });
            }));
  }

  Future<bool> _deleteConfirmAlert(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm meesage delete'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
