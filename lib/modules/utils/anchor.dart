import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String s) async {
  if (!await launch(s)) {
    // Show snackbar error no connection
    Fluttertoast.showToast(
      msg: "URL tidak didukung",
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
    );
  }
}
