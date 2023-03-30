import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();

  static const MaterialColor kPrimaryColor = MaterialColor(
    0xFF00C1B9,
    <int, Color>{
      50: Color.fromRGBO(0, 193, 185, .1),
      100: Color.fromRGBO(0, 193, 185, .2),
      200: Color.fromRGBO(0, 193, 185, .3),
      300: Color.fromRGBO(0, 193, 185, .4),
      400: Color.fromRGBO(0, 193, 185, .5),
      500: Color.fromRGBO(0, 193, 185, .6),
      600: Color.fromRGBO(0, 193, 185, .7),
      700: Color.fromRGBO(0, 193, 185, .8),
      800: Color.fromRGBO(0, 193, 185, .9),
      900: Color.fromRGBO(0, 193, 185, 1),
    },
  );

  static const Color background = Color(0xFFF7F7F7);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Color(0x00000000);
  static const Color green = Color(0xFF19B21D);
  static const Color purple = Color(0xFFCE06F2);
  static const Color bluePetrol = Color(0xFF19A3C1);
  static const Color blueDark = Color.fromARGB(255, 29, 92, 180);
  static const Color blue = Color(0xFF3967FF);
  static const Color lightBlue = Color(0xFF43A8F2);
  static const Color orange = Color(0xFFFF7F00);
  static const Color orangeThermometer = Color(0xFFFF9124);
  static const Color yellow = Color.fromARGB(255, 255, 208, 0);
  static const Color pink = Color(0xFFFF95F7);
  static const Color pinkAccent = Color(0xFFFF729E);
  static const Color red = Color(0xFFFC0A67);
  static const Color redAccent = Color(0xFFFF6464);
  static const Color gray = Color(0xFF6F6B6B);
  static const Color normalGray = Color(0xFF838383);
  static const Color darkGray = Color(0xFF454545);
  static const Color lightGray = Color(0xFFA3A3A3);
  static const Color colorDivider = Color(0xFFEBEBEB);

  static const Color neutral6 = Color(0xFFF1F2F9);
  static const Color neutral3 = Color(0xFFADAFC5);

  static LinearGradient buttonGradient(context, {Color? color}) =>
      LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color ?? Theme.of(context).primaryColor,
            color ?? Theme.of(context).primaryColor,
          ]);
}
