import 'package:flutter/material.dart';
import 'package:re_morable/components/slideshow_home.dart';
import 'package:re_morable/components/member_list.dart';
import 'package:re_morable/components/list_video.dart';
import 'package:re_morable/modules/slideshow_loading.dart';
import 'package:re_morable/modules/home_model.dart';
import 'package:re_morable/modules/fetch.dart';
import 'package:re_morable/modules/save_local.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? preExit;

  @override
  initState() {
    super.initState();

    if (SaveLocal.data == null) {
      getDataHome();
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
      setState(() {
        SaveLocal.data = HomeModel.fromJson(_result);
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
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: ListView(
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
            children: <Widget>[
              // when isError is true, hide slideshow
              SafeArea(
                  child: (SaveLocal.data == null)
                      ? const SlideshowLoading()
                      : SlideshowHome(tabSlideshow: SaveLocal.data!.slideshow)),
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
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                alignment: Alignment.topLeft,
                child: (SaveLocal.isError)
                    ? Container()
                    : const Text(
                        "Latest Videos",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
              ),
              //(isError) ? Container() : ListVideo(list: data!['list']),
            ],
          ),
          onRefresh: () async {
            //sleep 5000
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
              setState(() {
                SaveLocal.data = HomeModel.fromJson(_result);
                SaveLocal.isError = false;
              });
            }
          }),
    );
  }
}
