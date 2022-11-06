import 'package:flutter/material.dart';
import 'package:tute/pages/HomePage.dart';
import 'pages/AboutPage.dart';
import 'pages/AnimalPage.dart';

import 'pages/ContactPage.dart';
void main() {
  runApp(MITAppNew());
}
class MITAppNew extends StatelessWidget {
  const MITAppNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My New App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for(final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black45,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              label: tabItem.title,
            )
        ],
      ),
    );
  }
}

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;
  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });
  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: HomePage(),
      icon: Icon(Icons.home),
      title: "Home",
    ),
    TabNavigationItem(
      page: ContactPage(),
      icon: Icon(Icons.email),
      title: "Contact",
    ),
    TabNavigationItem(
      page: AboutPage(),
      icon: Icon(Icons.info),
      title: "About",
    ),
    TabNavigationItem(
      page: AnimalPage(),
      icon: Icon(Icons.pets),
      title: "Animals",
    ),
  ];
}