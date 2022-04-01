import 'package:flutter/material.dart';
import 'package:re_morable/components/slideshow_home.dart';
import 'info_member.dart';

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
        body: RefreshIndicator(
            child: ListView(
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              children: <Widget>[
                // add image slideshow
                const Slideshow(),
                // make header text
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
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
                // create list item flex row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // make item image top and text bottom and clickable
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const InfoVtuber(
                                        slug: "iofi",
                                      )));
                        },
                        child: Column(
                          children: [
                            // make image rounded
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/iofi.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // make text
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                "Iofi",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // make header text
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Latest Videos",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            onRefresh: () async {
              print("Refreshed");
            }),
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
          selectedItemColor: const Color.fromARGB(255, 43, 43, 43),
          onTap: (int index) {
            print(index);
          },
        ));
  }
}
