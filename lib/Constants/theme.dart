import 'package:flutter/material.dart';

final ThemeData ProxykhelThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: MaterialColor(ProxykhelColors.orange[500].value, ProxykhelColors.orange),
  primaryColor: ProxykhelColors.orange[500],
  primaryColorBrightness: Brightness.light,
  accentColorBrightness: Brightness.light,
  iconTheme: IconThemeData(
    color: Colors.white,
  )

);

class ProxykhelColors {
  ProxykhelColors._();
  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFF69A75),
    100: const Color(0xFFF4895E),
    200: const Color(0xFFF37847),
    300: const Color(0xFFF16730),
    400: const Color(0xFFF05619),
    500: const Color(0xFFEF4603),
    600: const Color(0xFFDA4003),
    700: const Color(0xFFC43A03),
    800: const Color(0xFFAE3303),
    900: const Color(0xFF992D02)
  };
}