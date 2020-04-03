import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:web_notify/redux/app_state.dart';

class Compose extends StatelessWidget {
  const Compose({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) { return store.state;},  // here I am getting Instance of 'HomeScreenComposeState'
      ignoreChange: (state) => state is! HomeScreenComposeState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // push elems to the left
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('To: ', style: TextStyle(fontSize: 16)),
                  OutlineButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(state.adresatas ?? ''),
                        SizedBox(width: 5),
                        Icon(Icons.clear, size: 14),
                      ],
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  Spacer(),
                  FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.blue,
                      hoverColor: Colors.redAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        print('send message');
                      },
                      icon: Icon(Icons.message),
                      label: Text('Send')),
                ],
              ),
              SizedBox(height: 1.0),
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                maxLines: 3,
              ),
            ],
          ),
        );
      }
    );
  }
}
