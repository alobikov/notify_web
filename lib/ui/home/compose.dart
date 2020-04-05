import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:web_notify/redux/actions/auth_actions.dart';
import 'package:web_notify/redux/app_state.dart';

class Compose extends StatelessWidget {
  const Compose({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, _ComposeViewModel>(
        distinct: false,
        converter: (_store) {
          print('converter???????????????');
          return _ComposeViewModel(
            store,
            state: _store.state,
          );
        }, // here I am getting Instance of 'HomeScreenComposeState'
        //       ignoreChange: (state) => state is! HomeScreenComposeState,
        builder: (context, _ComposeViewModel vm) {
          print(vm.hashCode);
          return Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // push elems to the left
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('To: ', style: TextStyle(fontSize: 16)),
                    vm.state.adresatas == null
                        ? Text(' Select recipient',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16))
                        : RecipientCard(store, vm.state.adresatas),
                    Spacer(),

                    // ButtonWithIcon('Send', Icons.message, vm.sendButtonState, onPressed: _sendMessage), //TODO

                    FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.blue,
                      hoverColor: Colors.redAccent,
                      textColor: Colors.white,
                      onPressed: vm.sendButtonState
                          ? () => print(vm.state.message)
                          : null,
                      icon: Icon(Icons.message),
                      label: Text('Send'),
                    ),
                  ],
                ),
                SizedBox(height: 1.0),
// ! TextField for message input
                TextField(
                  onChanged: (msg) {
                    store.dispatch(SetComposeState(message: msg));
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  maxLines: 3,
                ),
              ],
            ),
          );
        });
  }
}

class _ComposeViewModel {
  final dynamic state; // iam forced to use dynamic because of State uses mixin
  final store;
  bool sendButtonState = false;
  _ComposeViewModel(this.store, {this.state}) {
    if (state.message ?? 0 > 1 && state.adresatas != null) {
      sendButtonState = true;
    }
    print('constructor of _ComposeModel: sendButtonState=$sendButtonState');
  }
}

class RecipientCard extends StatelessWidget {
  final store;
  final String recipient;
  const RecipientCard(this.store, this.recipient, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
        onPressed: () {
          store.dispatch(
              SetComposeState(adresatas: '')); // remove recipient entirely
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(recipient),
            const SizedBox(width: 6.0),
            Icon(Icons.clear, size: 14),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
