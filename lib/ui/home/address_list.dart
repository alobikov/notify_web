import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:web_notify/redux/actions/auth_actions.dart';
import 'package:web_notify/redux/app_state.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key key}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return Container(
      // color: Colors.blue[100],
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (_ , __) =>
            const Divider(thickness: 1, indent: 10, endIndent: 10,),
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                store.dispatch(SetComposeState(adresatas: 'Mario-${index.toString()}'));
              },
              borderRadius: BorderRadius.all(Radius.circular(10)),
              hoverColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person, size: 20),
                      SizedBox(width: 5),
                      Container(
                        child: Text('Adresatas $index'),
                      ),
                      Spacer(),
                      Tooltip(
                          waitDuration: Duration(seconds: 1),
                          message: 'amount of messages Inbox/Outbox',
                          child: Text('4/10', style: TextStyle(fontSize: 10))),
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
}
