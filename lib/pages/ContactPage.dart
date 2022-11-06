import 'package:flutter/material.dart';


class ContactPage extends StatefulWidget {
 const ContactPage({Key? key}) : super(key: key);
 static Route<dynamic> route() => MaterialPageRoute(
  builder: (context) => ContactPage(),
 );

 @override
 State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: Text('Contact'),
   ),
   body: Container(
    margin: const EdgeInsets.all(10.0),
    child: Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[Text("Contact")],
    ),
   ),
  );
 }
}
