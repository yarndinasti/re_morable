import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Galery extends StatefulWidget {
  final String slug;
  const Galery({Key? key, required this.slug}) : super(key: key);

  @override
  State<Galery> createState() => _GaleryState();
}

class _GaleryState extends State<Galery> {
  PhotoViewScaleStateController? scaleStateController;
  // late PhotoViewController? photoViewController;

  @override
  void initState() {
    // photoViewController = PhotoViewController();

    // photoViewController?.position = const Offset(-70.0, 200.0);
    super.initState();
  }

  @override
  void dispose() {
    // photoViewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String slug = widget.slug;
// check posision screen vertical or horizontal
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double start = (orientation == Orientation.portrait) ? 1.5 : 3.0;
    final double maxScale = (orientation == Orientation.portrait) ? 3.0 : 6.0;

    // return PhotoView(
    //   backgroundDecoration: BoxDecoration(color: Colors.transparent),
    //   // controller: photoViewController,
    //   minScale: PhotoViewComputedScale.contained * 1,
    //   maxScale: PhotoViewComputedScale.contained * maxScale,
    //   onTapDown: (context, details, controller) {
    //     // print(photoViewController?.position);
    //   },
    //   onTapUp: (context, details, controller) {
    //     //scaleStateController!.scaleState = PhotoViewScaleState.initial;
    //     print("test");
    //   },
    //   // basePosition: Alignment.topCenter,
    //   initialScale: PhotoViewComputedScale.contained * start,
    //   imageProvider: AssetImage("assets/members/evelyn/body.png"),
    // );
    return Container();
  }
}
