import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListVideoLoading extends StatefulWidget {
  const ListVideoLoading({Key? key}) : super(key: key);

  @override
  State<ListVideoLoading> createState() => _ListVideoLoadingState();
}

class _ListVideoLoadingState extends State<ListVideoLoading> {
  List<Widget> _list = [];

  final double width = double.infinity;
  @override
  void initState() {
    super.initState();
    _list = List.generate(
      5,
      (index) => ListTile(
        leading: SizedBox(
          height: 100,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        title: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 18,
            color: Colors.grey,
          ),
        ),
        // make subtitle half of the width
        subtitle: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _list,
    );
  }
}
