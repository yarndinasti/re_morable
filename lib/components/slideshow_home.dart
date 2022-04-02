import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:re_morable/modules/anchor.dart';
import 'package:re_morable/modules/home_model.dart';

// ignore: must_be_immutable
class SlideshowHome extends StatefulWidget {
  // List<dynamic>
  final List<Slideshow> tabSlideshow;
  const SlideshowHome({Key? key, required this.tabSlideshow}) : super(key: key);

  @override
  State<SlideshowHome> createState() => _SlideshowHomeState();
}

class _SlideshowHomeState extends State<SlideshowHome> {
  final List<Widget> _slides = [];
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    //looping widget.tabSlideshow
    for (var i = 0; i < widget.tabSlideshow.length; i++) {
      // make slideshow clickable
      _slides.add(
        GestureDetector(
            onTap: () => launchURL(widget.tabSlideshow[i].url),
            child: Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 10),
              decoration: BoxDecoration(
                // add image + transparent black in foreground
                image: DecorationImage(
                  // when networkimage error, use container
                  image: NetworkImage(widget.tabSlideshow[i].thumbnail),

                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              // add text in bottom of image
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.black.withOpacity(0.4),
                ),
                child: Align(
                  child: Text(
                    widget.tabSlideshow[i].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              ),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: _slides,
            carouselController: _controller,
            options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.tabSlideshow.asMap().entries.map((entry) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
