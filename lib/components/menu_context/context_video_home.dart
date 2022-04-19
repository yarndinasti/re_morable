import 'package:flutter/material.dart';
import 'package:re_morable/modules/utils/anchor.dart';
import 'package:re_morable/models/home_model.dart';
import 'package:re_morable/models/members_model.dart';
import 'package:re_morable/modules/utils/save_local.dart';
import 'package:re_morable/rem_icons/re-memories_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:re_morable/views/info_member.dart';
import 'package:share_plus/share_plus.dart';

class ContextVideoHome {
  static void showContext(Videos video, BuildContext context) {
    Members member =
        SaveLocal.membersData!.firstWhere((m) => m.slug == video.from.slug);

    showModalBottomSheet(
        context: context,
        enableDrag: true,
        builder: (context) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            // video link
            ListTile(
              leading: Icon(
                (video.liveStatus == "upcoming")
                    ? FontAwesomeIcons.peopleGroup
                    : (video.liveStatus == "live")
                        ? Icons.circle
                        : FontAwesomeIcons.play,
                color: Colors.red,
                size: 25,
              ),
              title: Text((video.liveStatus == "upcoming")
                  ? "Go to Waiting Room"
                  : (video.liveStatus == "live")
                      ? "Watching Live"
                      : "Watch Video"),
              onTap: () {
                Navigator.of(context).pop();
                launchURL("https://www.youtube.com/watch?v=${video.id}");
              },
            ),

            // share video
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.share,
                color: Colors.blue,
                size: 25,
              ),
              title: Text((video.liveStatus == "none")
                  ? "Share Video"
                  : "Share Live Stream"),
              onTap: () {
                Navigator.of(context).pop();
                Share.share("https://www.youtube.com/watch?v=${video.id}",
                    subject: "${video.title} by ${video.from.name}");
              },
            ),

            // profile
            if (video.from.slug != "rem")
              ListTile(
                leading: Rem.colored(slug: video.from.slug),
                title: Text("${video.from.name}'s profile"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InfoVtuber(member: member)),
                  );
                },
              ),

            // go to channels
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
                size: 25,
              ),
              title: Text("${video.from.name}'s channel"),
              onTap: () {
                Navigator.of(context).pop();
                launchURL(
                    "https://www.youtube.com/channel/${video.from.channelId}");
              },
            ),
          ]);
        });
  }
}
