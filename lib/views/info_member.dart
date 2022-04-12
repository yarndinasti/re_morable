import 'package:flutter/material.dart';
import 'package:re_morable/components/galery_member.dart';
import 'package:re_morable/models/members_model.dart';
import 'package:re_morable/rem_icons/re-memories_icons.dart';
import 'page_member/index.dart';

class InfoVtuber extends StatefulWidget {
  final Members member;
  const InfoVtuber({Key? key, required this.member}) : super(key: key);

  @override
  State<InfoVtuber> createState() => _InfoVtuberState();
}

class _InfoVtuberState extends State<InfoVtuber> {
  final PageController ctrl =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final Color _color = (widget.member.slug == "evelyn")
        ? Color.fromARGB(255, 255, 227, 236)
        : (widget.member.slug == "lily")
            ? Color.fromARGB(255, 213, 243, 255)
            : Color.fromARGB(255, 255, 255, 255);
    return Scaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: PageView(
            controller: ctrl,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              MemberHome(member: widget.member),
              Galery(slug: widget.member.slug),
            ]),
      ),
      backgroundColor: _color,
      // add appbar with back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
