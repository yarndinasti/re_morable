import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'context_menu_member.dart';
import 'package:re_morable/modules/members_model.dart';

class MemberList extends StatefulWidget {
  const MemberList({Key? key}) : super(key: key);

  // get members from local json file
  Future<List<Members>> getMembers() async {
    final String jsonString = await rootBundle.loadString('data/members.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> jsonList = jsonMap['members'];
    final List<Members> members =
        jsonList.map((dynamic json) => Members.fromJson(json)).toList();
    return members;
  }

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  // ignore: non_constant_identifier_names
  List<Members> members = [];

  @override
  void initState() {
    super.initState();
    widget.getMembers().then((value) {
      setState(() {
        members = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // make container position in center
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 104,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10, right: 10),
        shrinkWrap: true,
        children: members
            .map(
              (member) => Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(member.slug);
                  },
                  onLongPress: () {
                    // show menu in bottom screen
                    ContextMenuMember.showContext(member, context);
                  },
                  child: Column(
                    children: [
                      // make image rounded
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                            )
                          ],
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/members/${member.slug}/icon-preview.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // make text
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          member.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
