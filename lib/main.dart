import 'package:flutter/material.dart';
import 'package:web_notify/ui/registration_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CentredView(
        child: Scaffold(
          body: RegistrationForm(),
        ),
      ),
    );
  }
}

//! selfmade widget with parameter
class _NavigationBarItem extends StatelessWidget {
  final String title;
  const _NavigationBarItem(this.title);
  @override
  Widget build(BuildContext context) {
    return CentredView(child: Text(title, style: TextStyle(fontSize: 24)));
  }
}

class CentredView extends StatelessWidget {
  final Widget child;
  const CentredView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 370, maxHeight: 600),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0), child: child)),
    );
  }
}
