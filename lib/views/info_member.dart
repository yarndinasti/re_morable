import 'package:flutter/material.dart';

class InfoVtuber extends StatelessWidget {
  final String slug;
  const InfoVtuber({Key? key, required this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // add appbar with back button
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Iofi"),
        foregroundColor: Colors.black,
        leading: IconButton(
          // make icon black
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
