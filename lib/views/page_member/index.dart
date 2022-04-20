import 'package:flutter/material.dart';
import 'package:re_morable/components/menu_context/context_menu_member.dart';
import 'package:re_morable/models/members_model.dart';

class MemberHome extends StatefulWidget {
  final Members member;
  const MemberHome({Key? key, required this.member}) : super(key: key);

  @override
  State<MemberHome> createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/members/${widget.member.slug}/logo.png",
              height: 100,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            // detection st,nd,rd,th
            "${getGenNum(widget.member.gen)} Generation",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Bridthay",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            widget.member.birthday,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Height",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            widget.member.height,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Characher Desinger",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            widget.member.designer,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Biography",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 50),
            child: Text(
              widget.member.description.en,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // make buttons inside box
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              // make button rounded and now shadow use ElevatedButton
              ElevatedButton(
                child: Text("View ${widget.member.name.split(" ")[0]} Videos"),
                onPressed: () => null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                child: const Text("Social Media"),
                onPressed: () =>
                    ContextMenuMember.showContext(widget.member, context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getGenNum(int gen) {
    // split number then sort reverse
    final numbers = gen.toString().split("").reversed.toList();
    // get last number (in first list)
    final lastEntry = numbers.first;
    // detect number
    switch (lastEntry) {
      case "1":
        return "${gen}st";
      case "2":
        return "${gen}nd";
      case "3":
        return "${gen}rd";
      default:
        return "${gen}th";
    }
  }
}
