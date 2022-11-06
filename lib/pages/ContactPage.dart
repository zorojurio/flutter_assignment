import 'package:flutter/material.dart';


class ContactPage extends StatelessWidget {
 static Route<dynamic> route() => MaterialPageRoute(
  builder: (context) => ContactPage(),
 );
 @override
 Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
       title: Text("Contact us"),
      ),
      body: MyCustomForm()
  );
 }
}
class MyCustomForm extends StatefulWidget {
 @override
 MyCustomFormState createState() {
  return MyCustomFormState();
 }
}
// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
// Create a global key that uniquely identifies the Form widget
// and allows validation of the form.
//
// Note: This is a GlobalKey<FormState>,
// not a GlobalKey<MyCustomFormState>.
 final _formKey = GlobalKey<FormState>();
 bool valuefirst = false;
 bool valuesecond = false;
 String sponsorTimes = "Monthly";
 String amount = '£10';
 @override
 Widget build(BuildContext context) {
// Build a Form widget using the _formKey created above.
  return Scaffold(
   body: SingleChildScrollView(
    child: ConstrainedBox(
     constraints: BoxConstraints(
      minWidth: MediaQuery
          .of(context)
          .size
          .width,
      minHeight: MediaQuery
          .of(context)
          .size
          .height,
     ),
     child: Form(
      key: _formKey,
      child: Column(
       children: <Widget>[
        const Text("Your Name"),
        TextFormField(
         decoration: InputDecoration(
             border: OutlineInputBorder(),
             hintText: 'Enter your name'),
// The validator receives the text that the user has entered.
         validator: (value) {
          if (value == null || value.isEmpty) {
           return 'Please enter some text';
          }
          return null;
         },
        ),
        const Text("Your Preferred Breed"),
        TextFormField(
         decoration: const InputDecoration(
             border: OutlineInputBorder(),
             hintText: 'Enter your prefered breed'),
// The validator receives the text that the user has entered.
         validator: (value) {
          if (value == null || value.isEmpty) {
           return 'Please enter some text';
          }
          return null;
         },
        ),
        const Text(
            'Which animal do you want to sponsor (Select at least one)'),
        CheckboxListTile(
         secondary: const Icon(Icons.pets),
         title: const Text('Falcor'),
         subtitle: Text('Furry dog'),
         value: this.valuefirst,
         onChanged: (bool? value) {
          setState(() {
           this.valuefirst = value!;
          });
         },
        ),
        CheckboxListTile(
         controlAffinity: ListTileControlAffinity.trailing,
         secondary: const Icon(Icons.pets),
         title: const Text('Moon'),
         subtitle: Text('A cat'),
         value: this.valuesecond,
         onChanged: (bool? value) {
          setState(() {
           this.valuesecond = value!;
          });
         },
        ),
        Text('How often do you want to sponsor'),
        ListTile(
         title: const Text('Weekly'),
         leading: Radio(
          value: "Weekly",
          groupValue: sponsorTimes,
          onChanged: (String? value) {
           setState(() {
            sponsorTimes = value!;
            print(sponsorTimes);
           });
          },
         ),
        ),
        ListTile(
         title: const Text('Monthly'),
         leading: Radio(
          value: "Monthly",
          groupValue: sponsorTimes,
          onChanged: (String? value) {
           setState(() {
            sponsorTimes = value!;
            print(sponsorTimes);
           });
          },
         ),
        ),
        ListTile(
         title: const Text('Yearly'),
         leading: Radio(
          value: "Yearly",
          groupValue: sponsorTimes,
          onChanged: (String? value) {
           setState(() {
            sponsorTimes = value!;
            print(sponsorTimes);
           });
          },
         ),
        ),
        const Text('How much do you want to pay for each sponsorship?'),
        DropdownButton<String>(
         value: amount,
         icon: const Icon(Icons.arrow_downward),
         iconSize: 24,
         elevation: 16,
         style: const TextStyle(color: Colors.deepPurple),
         underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
         ),
         onChanged: (String? newValue) {
          setState(() {
           amount = newValue!;
          });
         },
         items: <String>['£2', '£5', '£10', '£20']
             .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
           value: value,
           child: Text(value),
          );
         }).toList(),),
        ElevatedButton(
         onPressed: () {
// Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
// If the form is valid, display a snackbar. In the real world,
// you'd often call a server or save the information in a database.
           ScaffoldMessenger.of(context)
               .showSnackBar(SnackBar(content: Text(
               'Processing Data')));
          }
         },
         child: Text('Submit'),
        ),
       ],
      ),
     ),
    ),
   ),
  );
 }
}