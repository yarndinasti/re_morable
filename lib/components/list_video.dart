import 'package:flutter/material.dart';
import 'package:re_morable/modules/anchor.dart';

class ListVideo extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final list;
  const ListVideo({Key? key, required this.list}) : super(key: key);

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  List<Widget> theList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      //looping widget.list
      for (var i = 0; i < widget.list.length; i++) {
        theList.add(
          ListTile(
            title: Text(widget.list[i]['title']),
            subtitle: Text(widget.list[i]['member']['name']),
            leading: Image.network(
              widget.list[i]['mini_thumbnail'],
              fit: BoxFit.cover,
              width: 90,
              height: 90 / 16 * 9,
            ),
            onTap: () => launchURL(
                'https://youtube.com/watch?v=${widget.list[i]['id']}'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: theList,
    );
  }
}
