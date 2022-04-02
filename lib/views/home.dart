import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:re_morable/components/slideshow_home.dart';
import 'package:re_morable/components/member_list.dart';
import 'package:re_morable/components/list_video.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Home extends StatefulWidget {
  // init data object
  // ignore: prefer_typing_uninitialized_variables
  var data;
  bool isError;

  Home({Key? key, this.data, required this.isError}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // init RefreshIndicator when open app

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: ListView(
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: true,
          children: <Widget>[
            // when isError is true, hide slideshow
            widget.isError
                ? Container()
                : Slideshow(tabSlideshow: widget.data!['tab']),
            // make header text
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Members",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            // create list item flex row
            const MemberList(),
            // make header text
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
              alignment: Alignment.topLeft,
              child: (widget.isError)
                  ? Container()
                  : const Text(
                      "Latest Videos",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
            ),
            (widget.isError)
                ? Container()
                : ListVideo(list: widget.data!['list']),
          ],
        ),
        onRefresh: () async {
          //sleep 5000
          const apiUrl = 'http://rem-play-server.yansaan.repl.co/on-app';

          try {
            final response = await http.get(Uri.parse(apiUrl));

            setState(() {
              widget.data = json.decode(response.body);
              widget.isError = false;
            });
            print(widget.data);
          } catch (e) {
            setState(() {
              widget.isError = true;
            });
            print(e);
          }

          print(widget.isError);
        });
  }
}
