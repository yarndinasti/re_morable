import 'package:flutter/material.dart';

class MemberList extends StatefulWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  // ignore: non_constant_identifier_names
  List<Widget> list_member = [];

  @override
  void initState() {
    super.initState();

    final member = [
      {'name': "Evelyn Vtuber", 'slug': 'evelyn'},
      {'name': "Lily Ifeta", 'slug': 'lily'},
      {'name': "Reynard Blanc", 'slug': 'reynard'},
      {'name': "Chloe Pawapua", 'slug': 'chloe'},
    ];

    print(member);

    for (var i = 0; i < member.length; i++) {
      list_member.add(
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(member[i]['slug'].toString());
            },
            onLongPress: () {
              // show menu in bottom screen
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            member[i]['name'].toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "UwU",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
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
                          "assets/members/${member[i]['slug']}/icon-preview.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // make text
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    member[i]['name'].toString(),
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
      );
    }
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
        children: list_member,
      ),
    );
  }
}
