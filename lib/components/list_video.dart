import 'package:flutter/material.dart';
import 'package:re_morable/modules/anchor.dart';
import 'package:re_morable/modules/home_model.dart';

class ListVideo extends StatefulWidget {
  final List<Videos> list;
  const ListVideo({Key? key, required this.list}) : super(key: key);

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Container()],
    );
  }
}
