import 'package:flutter/material.dart';
import 'package:re_morable/models/members_model.dart';
import 'package:re_morable/rem_icons/re-memories_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:re_morable/modules/anchor.dart';

class ContextMenuMember {
  // get members
  static void showContext(Members member, BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // add icon in rght text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Rem.colored(slug: member.slug),
                      const SizedBox(width: 5),
                      Text(
                        member.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // menu context here

                  // youtube
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.youtube,
                      color: Colors.red,
                      size: 25,
                    ),
                    title: Text("Go to ${member.name.split(" ")[0]}'s channel"),
                    onTap: () {
                      Navigator.of(context).pop();
                      launchURL(
                          "https://www.youtube.com/channel/${member.channelId}");
                    },
                  ),

                  // share yt channel
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.share,
                      color: Color.fromRGBO(255, 152, 0, 1),
                      size: 25,
                    ),
                    title: Text("Share ${member.name.split(" ")[0]}'s channel"),
                    onTap: () {
                      Navigator.of(context).pop();
                      Share.share(
                          "https://youtube.com/channel/${member.channelId}");
                    },
                  ),

                  // Twitter
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.blue,
                      size: 25,
                    ),
                    title: const Text("Twitter"),
                    onTap: () {
                      Navigator.of(context).pop();
                      launchURL("https://twitter.com/${member.twitter}");
                    },
                  ),

                  // Instagram
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.red,
                      size: 25,
                    ),
                    title: const Text("Instagram"),
                    onTap: () {
                      Navigator.of(context).pop();
                      launchURL("https://instagram.com/${member.instagram}");
                    },
                  ),

                  // Facebook when exist
                  if (member.facebook != null)
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        size: 25,
                      ),
                      title: const Text("Facebook"),
                      onTap: () {
                        Navigator.of(context).pop();

                        launchURL("https://facebook.com/${member.facebook}");
                      },
                    ),

                  // Trakteer
                  ListTile(
                    leading: const Icon(
                      Rem.trakteer,
                      color: Colors.red,
                      size: 25,
                    ),
                    title: const Text("Donate to Trakteer (IDR)"),
                    onTap: () {
                      Navigator.of(context).pop();
                      launchURL(
                          "https://trakteer.id/${member.donate.trakteer}");
                    },
                  ),

                  // Karyakarsa
                  if (member.donate.karyakarsa != null)
                    ListTile(
                      leading: const Icon(
                        Rem.karyakarsa,
                        color: Colors.red,
                        size: 25,
                      ),
                      title: const Text("Donate to Karyakarsa (IDR)"),
                      onTap: () {
                        Navigator.of(context).pop();
                        launchURL(
                            "https://karyakarsa.com/${member.donate.karyakarsa}");
                      },
                    ),

                  // Streamlabs
                  ListTile(
                    leading: const Icon(
                      Rem.streamlabs,
                      // get color from code color
                      color: Color(0xFF93D3C1),
                      size: 25,
                    ),
                    title: const Text("Donate to Streamlabs (USD)"),
                    onTap: () {
                      Navigator.of(context).pop();
                      launchURL(
                          "https://streamlabs.com/${member.donate.steamlabs}/donate");
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
