import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontThemeClass {
  TextStyle primaryTitle(BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Color.fromRGBO(0, 74, 173, 1),
        letterSpacing: .5,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle descrtiption(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle bodytitile(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Color.fromRGBO(0, 74, 173, 1),
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle buttonText(BuildContext context, {Color? color}) {
    return GoogleFonts.lato(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
