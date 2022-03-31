import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // create appBar without shadow and transparent background
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/logo-dark.png'),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: true,
          children: <Widget>[
            // add image slideshow
            Container(
              height: 300,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1,
                  initialPage: 0,
                ),
                items: [
                  'assets/oj.jpg',
                  'assets/oj.jpg',
                  'assets/oj.jpg',
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        // clickable to url
                        child: GestureDetector(
                          onTap: () async {
                            await _launchURL(
                                "https://youtube.com/watch?v=dQw4w9WgXcQ");
                          },
                          child: Image.asset(
                            i,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            // make header text
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Members",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            // create list item grid
          ],
        ),
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
          currentIndex: 0,
          selectedItemColor: Color.fromARGB(255, 43, 43, 43),
          onTap: (int index) {
            print(index);
          },
        ));
  }
}

_launchURL(String s) async {
  if (!await launch(s)) throw 'Could not launch $s';
}
