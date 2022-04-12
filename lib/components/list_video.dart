import 'package:flutter/material.dart';
import 'package:re_morable/modules/anchor.dart';
import 'package:re_morable/rem_icons/re-memories_icons.dart';
import 'package:re_morable/models/home_model.dart';
import 'package:shimmer/shimmer.dart';
import 'context_video_home.dart';

class ListVideo extends StatefulWidget {
  final List<Videos> list;
  const ListVideo({Key? key, required this.list}) : super(key: key);

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list.map((e) {
        String? status;
        // convert unix time to date
        switch (e.liveStatus) {
          case "upcoming":
            // when date now (unix) < e.live.startTime
            if (DateTime.now().millisecondsSinceEpoch < e.live!.startStream) {
              // math.floor

              int timeRemain = ((e.live!.startStream -
                          DateTime.now().millisecondsSinceEpoch) /
                      1000)
                  .floor();

              // convert to day/hour/minute/second in array
              String timeRemainStr = [
                "${timeRemain ~/ 86400} day${timeRemain ~/ 86400 > 1 ? "s" : ""}",
                "${timeRemain % 86400 ~/ 3600} hour${timeRemain % 86400 ~/ 3600 > 1 ? "s" : ""}",
                "${timeRemain % 3600 ~/ 60} minute${timeRemain % 3600 ~/ 60 > 1 ? "s" : ""}",
                "${timeRemain % 60} second${timeRemain % 60 > 1 ? "s" : ""}"
              ].firstWhere((element) => !element.contains(RegExp(r"^0 ")));

              // convert to string

              status = "Upcoming in $timeRemainStr";
            } else {
              status = "Upcoming in few moments";
            }
            break;
          case "live":
            status = "Live Now";
            break;
          default:
            int time;
            if (e.live != null) {
              time = ((DateTime.now().millisecondsSinceEpoch -
                          e.live!.endStream!) /
                      1000)
                  .floor();
            } else {
              time =
                  ((DateTime.now().millisecondsSinceEpoch - e.published) / 1000)
                      .floor();
            }

            // convert to year/month/day/hour/minute/second in array
            String timeRemainStr = [
              "${time ~/ 31536000} year${time ~/ 31536000 > 1 ? "s" : ""}",
              "${time % 31536000 ~/ 2592000} month${time % 31536000 ~/ 2592000 > 1 ? "s" : ""}",
              "${time % 2592000 ~/ 86400} day${time % 2592000 ~/ 86400 > 1 ? "s" : ""}",
              "${time % 86400 ~/ 3600} hour${time % 86400 ~/ 3600 > 1 ? "s" : ""}",
              "${time % 3600 ~/ 60} minute${time % 3600 ~/ 60 > 1 ? "s" : ""}",
              "${time % 60} second${time % 60 > 1 ? "s" : ""}"
            ].firstWhere((element) => !element.contains(RegExp(r"^0 ")));
            status = "$timeRemainStr ago";
        }

        return ListTile(
          // add 3 dot menu
          onLongPress: () => ContextVideoHome.showContext(e, context),
          onTap: () => launchURL("https://www.youtube.com/watch?v=${e.id}"),

          leading: SizedBox(
            height: 100,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(e.thumbnail.mini, fit: BoxFit.cover,
                  loadingBuilder: (ctx, child, progress) {
                if (progress == null) return child;
                return Shimmer.fromColors(
                  highlightColor: const Color.fromARGB(255, 224, 224, 224),
                  baseColor: const Color.fromARGB(255, 202, 202, 202),
                  child: Container(
                    color: Colors.grey,
                  ),
                );
              }, errorBuilder: (context, err, stackTrace) {
                print(err);
                return Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                );
              }),
            ),
          ),
          title: Text(e.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
          // make subtitle half of the width
          subtitle: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Rem.colored(slug: e.from.slug, size: 18),
                Text(
                  " ${e.from.name} - ",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 13,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: e.liveStatus == "live"
                        ? Colors.red
                        : const Color.fromARGB(255, 61, 61, 61),
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
