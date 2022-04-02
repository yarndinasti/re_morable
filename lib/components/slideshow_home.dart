import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:re_morable/modules/anchor.dart';

// ignore: must_be_immutable
class Slideshow extends StatefulWidget {
  // List<dynamic>
  final List<dynamic> tabSlideshow;
  const Slideshow({Key? key, required this.tabSlideshow}) : super(key: key);

  @override
  State<Slideshow> createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
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
        items: widget.tabSlideshow.map((i) {
          return Builder(
            builder: (BuildContext context) {
              // Add text inside image
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // add image + transparent black in foreground
                  image: DecorationImage(
                    // get image online
                    image: NetworkImage(i['thumbnail']),
                    fit: BoxFit.cover,
                  ),
                ),
                // add text in bottom of image
                child: GestureDetector(
                  onTap: () => launchURL(i['url']),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      // get i.title in Text()
                      child: Text(
                        i['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
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
