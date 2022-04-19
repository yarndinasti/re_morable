import 'package:flutter/material.dart';
import 'home.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  List<Widget> homeView = [
    const Home(),
    const Center(
      child: Text("Halaman ini masih dalam pengerjaan"),
    ),
    const Center(
      child: Text("Halaman ini masih dalam pengerjaan"),
    ),
  ];

  final title = [
    Image.asset(
      'assets/logo_dark.png',
      height: 24,
    ),
    const Text('News'),
    const Text('More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // create appBar without shadow and transparent background
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: _currentIndex == 0 ? true : false,
          title: title[_currentIndex],
          foregroundColor: Colors.black,
        ),
        body: homeView[_currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: const Color.fromARGB(255, 192, 192, 192),
              labelTextStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
          child: NavigationBar(
              backgroundColor: const Color.fromARGB(255, 238, 238, 238),
              height: 60,
              selectedIndex: _currentIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.newspaper_outlined),
                  selectedIcon: Icon(Icons.newspaper),
                  label: 'News',
                ),
                NavigationDestination(
                  icon: Icon(Icons.info_outline_rounded),
                  selectedIcon: Icon(Icons.info_rounded),
                  label: 'More',
                ),
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              }),
        ));
  }
}
