import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SlideshowLoading extends StatefulWidget {
  const SlideshowLoading({Key? key}) : super(key: key);

  @override
  State<SlideshowLoading> createState() => _SlideshowLoadingState();
}

class _SlideshowLoadingState extends State<SlideshowLoading> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Shimmer.fromColors(
      highlightColor: const Color.fromARGB(255, 224, 224, 224),
      baseColor: const Color.fromARGB(255, 202, 202, 202),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 202, 202, 202),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: (orientation == Orientation.portrait)
                      ? 16 / 8.75
                      : 16 / 2.75,
                  child: Container(
                    color: Colors.grey,
                  ),
                )),
          ),
          const SizedBox(height: 5),
          Container(
            width: 8,
            height: 8,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
