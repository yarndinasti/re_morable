import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:re_morable/modules/anchor.dart';

class Slideshow extends StatelessWidget {
  const Slideshow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 16 * 9,
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.width / 16 * 9,
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
              // Add text inside image
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // add image + transparent black in foreground
                  image: DecorationImage(
                    image: AssetImage(i),
                    fit: BoxFit.cover,
                  ),
                ),
                // add text in bottom of image
                child: GestureDetector(
                  onTap: () =>
                      launchURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    padding: const EdgeInsets.all(16),
                    child: const Align(
                      child: Text(
                        'OJ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
