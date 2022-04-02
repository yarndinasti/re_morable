import 'package:flutter/material.dart';

class MemberList extends StatelessWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // make item image top and text bottom and clickable
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("iofi");
            },
            child: Column(
              children: [
                // make image rounded
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/iofi.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // make text
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Iofi",
                    style: TextStyle(
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
      ],
    );
  }
}
