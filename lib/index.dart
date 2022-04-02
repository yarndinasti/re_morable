import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:re_morable/modules/loading_page.dart';
import 'views/home.dart';
import 'package:http/http.dart' as http;

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  List<Widget> homeView = [
    const LoadingPage(),
    const Center(
      child: Text("Halaman ini masih dalam pengerjaan"),
    ),
    const Center(
      child: Text("Halaman ini masih dalam pengerjaan"),
    ),
  ];

  final title = [
    Image.asset('assets/logo-dark.png'),
    const Text('News'),
    const Text('More'),
  ];

  Future<void> _fetchData() async {
    super.initState();
    // get data from api
    try {
      const apiUrl = 'http://rem-play-server.yansaan.repl.co/on-app';

      final response = await http.get(Uri.parse(apiUrl));
      final data = json.decode(response.body);

      setState(() {
        homeView[0] = Home(data: data, isError: false);
      });
    } catch (e) {
      // when error
      setState(() {
        print(e);
        homeView[0] = Home(isError: true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

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
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'More',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: const Color.fromARGB(255, 43, 43, 43),
          onTap: (int index) => setState(() => _currentIndex = index),
        ));
  }
}

class MasterHome extends StatefulWidget {
  const MasterHome({Key? key}) : super(key: key);

  @override
  State<MasterHome> createState() => _MasterHomeState();
}

class _MasterHomeState extends State<MasterHome> {
  String uri = "";
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
