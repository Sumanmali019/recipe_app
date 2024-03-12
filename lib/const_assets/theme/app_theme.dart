import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recepi_application/const_assets/theme/app_colors.dart';

final mainTheme = FlexThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.onBoardingButtonColor,
    //
    textTheme: const TextTheme().copyWith(
      bodyLarge: GoogleFonts.lato(
        color: Colors.white,
        height: 1.4,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),

      titleSmall: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),

      bodySmall: GoogleFonts.lato(
          fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
      //
      headlineMedium:
          const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      //
      titleMedium: GoogleFonts.lato(
          color: Colors.white,
          height: 1.4,
          fontSize: 17,
          fontWeight: FontWeight.w700),

      //
      titleLarge: GoogleFonts.lato(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      displaySmall: const TextStyle(
        fontSize: 36,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      //
      labelMedium: GoogleFonts.lato(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      //
      labelLarge: const TextStyle(
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
    ),
    //

    cardTheme: CardTheme(
        color: AppColors.bluecolur,
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))));
