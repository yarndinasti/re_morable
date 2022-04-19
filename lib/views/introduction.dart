import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:re_morable/modules/save_local.dart';

import '../index.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  bool _isPop = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(_isPop),
      child: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Selamat Datang di Re:Morable",
              body: "test1",
            ),
            PageViewModel(
              title: "test",
              body: "test2",
            ),
            PageViewModel(
              title: "test",
              body: "test3",
            ),
            PageViewModel(
              title: "test",
              bodyWidget: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text("test"),
                    ),
                  ),
                ],
              ),
              footer: ElevatedButton(
                child: const Text("Save notification"),
                onPressed: () {
                  // SharedPreferences.getInstance().then((prefs) {
                  //   prefs.setBool("notInit", true);
                  // });

                  setState(() {
                    SaveLocal.noInit = true;
                    _isPop = true;
                  });
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
          // get index page

          // Skip button
          skip: const Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 2.5),
            child: Text(
              "Skip",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          showSkipButton: true,
          // Next button
          next: const Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 2.5),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          showDoneButton: false,
        ),
      ),
    );
  }
}
