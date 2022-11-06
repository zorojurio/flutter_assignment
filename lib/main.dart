import 'package:flutter/material.dart';
import 'package:tute/pages/HomePage.dart';
import 'pages/AboutPage.dart';
import 'pages/AnimalPage.dart';

import 'pages/ContactPage.dart';

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
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
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
          icon: const Icon(Icons.home),
          title: "Home",
        ),
        TabNavigationItem(
          page: ContactPage(),
          icon: const Icon(Icons.email),
          title: "Contact",
        ),
        TabNavigationItem(
          page: const AboutPage(),
          icon: const Icon(Icons.info),
          title: "About",
        ),
        TabNavigationItem(
          page: AnimalPage(),
          icon: const Icon(Icons.pets),
          title: "Animals",
        ),
      ];
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      );
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
          for (final tabItem in TabNavigationItem.items) tabItem.page,
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
