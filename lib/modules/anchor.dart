import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String s) async {
  if (!await launch(s)) {
    // Show snackbar error no connection
    final snackbar = SnackBar(
      content: const Text("Link broken"),
      action: SnackBarAction(
        label: "OK",
        // ignore: avoid_returning_null_for_void
        onPressed: () => null,
      ),
    );
  }
}
