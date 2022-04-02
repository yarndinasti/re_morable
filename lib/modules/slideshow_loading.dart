import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SlideshowLoading extends StatefulWidget {
  const SlideshowLoading({Key? key}) : super(key: key);

  @override
  State<SlideshowLoading> createState() => _SlideshowLoadingState();
}

class _SlideshowLoadingState extends State<SlideshowLoading> {
  List<Widget> dot = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 5; i++) {
      dot.add(Container(
        width: 8,
        height: 8,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      ));
      dot.add(const SizedBox(width: 4));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: const Color.fromARGB(255, 224, 224, 224),
      baseColor: const Color.fromARGB(255, 202, 202, 202),
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 202, 202, 202),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.grey,
                  ),
                )),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dot,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
