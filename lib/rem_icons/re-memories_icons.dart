// Place fonts/re-memories.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: re-memories
//      fonts:
//       - asset: fonts/re-memories.ttf
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Rem {
  Rem._();

  static const String _fontFamily = 're-memories';

  static const IconData karyakarsa = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData streamlabs = IconData(0xe907, fontFamily: _fontFamily);
  static const IconData chloe = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData evelyn = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData lily = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData rememories = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData reynard = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData trakteer = IconData(0xe905, fontFamily: _fontFamily);

  static Icon colored({required String slug, double size = 25}) {
    Icon icons = (slug == "evelyn")
        ? Icon(Rem.evelyn, color: Colors.lightBlue, size: size)
        : (slug == "lily")
            ? Icon(Rem.lily,
                color: const Color.fromARGB(255, 240, 168, 60), size: size)
            : (slug == "reynard")
                ? Icon(Rem.reynard,
                    color: const Color.fromARGB(255, 54, 54, 54), size: size)
                : (slug == "chloe")
                    ? Icon(Rem.chloe, color: Colors.green, size: size)
                    : Icon(Rem.rememories,
                        color: const Color.fromARGB(255, 24, 31, 41),
                        size: size);

    return icons;
  }
}
