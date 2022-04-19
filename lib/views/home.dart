import 'package:flutter/material.dart';
import 'package:re_morable/components/slideshow_home.dart';
import 'package:re_morable/components/member_list.dart';
import 'package:re_morable/modules/list_video_loading.dart';
import 'package:re_morable/components/list_video.dart';
import 'package:re_morable/modules/slideshow_loading.dart';
import 'package:re_morable/models/home_model.dart';
import 'package:re_morable/modules/fetch.dart';
import 'package:re_morable/modules/save_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:re_morable/views/introduction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'introduction.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? preExit;

  @override
  initState() {
    initFirst();
    super.initState();

    if (SaveLocal.slideshowData == null || SaveLocal.videosData == null) {
      getDataHome();
    }
  }

  Future<void> initFirst() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool notInit = (pref.getBool('notInit')) ?? false;

    if (!notInit && !SaveLocal.noInit) {
      // show introduction
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Introduction()),
      );
    }
  }

  Future<void> getDataHome() async {
    final _result = await RemoteService.getData(
        "http://rem-play-server.yansaan.repl.co/on-app");

    if (_result == null) {
      setState(() {
        SaveLocal.isError = true;
      });
      // add message
      final snackBar = SnackBar(
        content: const Text("Check your internet connection lol"),
        action: SnackBarAction(
          label: "OK",
          // ignore: avoid_returning_null_for_void
          onPressed: () => null,
        ),
      );

      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final HomeModel result = HomeModel.fromJson(_result);

      setState(() {
        SaveLocal.slideshowData = result.slideshow;
        SaveLocal.videosData = result.videos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final initApp = DateTime.now().subtract(const Duration(seconds: 10));

        final timegap =
            DateTime.now().difference(preExit != null ? preExit! : initApp);

        final onExit = timegap < const Duration(seconds: 5);
        if (onExit) return true;

        setState(() {
          preExit = DateTime.now();
        });

        // add toast in botom screen
        Fluttertoast.showToast(
          msg: "Mau keluar? Tekan/swipe back lagi!",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
        );

        return false;
      },
      child: RefreshIndicator(
          child: ListView(
            // when data null, don't scroll
            physics: (SaveLocal.videosData != null || SaveLocal.isError == true)
                ? const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics())
                : const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
            children: <Widget>[
              // when isError is true, hide slideshow
              SafeArea(
                child: (SaveLocal.slideshowData != null)
                    ? SlideshowHome(tabSlideshow: SaveLocal.slideshowData!)
                    : (SaveLocal.isError)
                        ? Container()
                        : const SlideshowLoading(),
              ),
              // make header text
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Members",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              // create list item flex row
              const MemberList(),
              // make header text
              (SaveLocal.isError)
                  ? Container()
                  : Container(
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Videos",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
              (SaveLocal.videosData != null)
                  ? ListVideo(list: SaveLocal.videosData!)
                  : (SaveLocal.isError)
                      ? const Center(
                          // make height full
                          child: Text(
                            "Maaf, silahkan restart wifi anda",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : const ListVideoLoading(),
            ],
          ),
          onRefresh: () async {
            setState(() {
              SaveLocal.videosData = null;
              SaveLocal.isError = false;
            });

            final _result = await RemoteService.getData(
                "http://rem-play-server.yansaan.repl.co/on-app");

            if (_result == null) {
              setState(() {
                SaveLocal.isError = true;
              });
              // add message
              final snackBar = SnackBar(
                content: const Text("Check your internet connection lol"),
                action: SnackBarAction(
                  label: "OK",
                  // ignore: avoid_returning_null_for_void
                  onPressed: () => null,
                ),
              );

              // show snackbar
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              setState(() => SaveLocal.slideshowData = null);
              // slepp 100ms
              await Future.delayed(const Duration(milliseconds: 100));
              final HomeModel result = HomeModel.fromJson(_result);

              setState(() {
                SaveLocal.slideshowData = result.slideshow;
                SaveLocal.videosData = result.videos;
              });
            }
          }),
    );
  }
}
