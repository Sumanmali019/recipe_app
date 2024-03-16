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
          color: Colors.red,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),

      //steps_list
      bodySmall: GoogleFonts.lato(
          fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),

      //steps_ingreditant
      titleMedium: GoogleFonts.alice(
          color: Colors.white,
          height: 1.6,
          fontSize: 17,
          fontWeight: FontWeight.bold),

      //recepi_name
      titleLarge: GoogleFonts.alice(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),

      //recepi_cal && recepi_card_cal_infro
      labelMedium: GoogleFonts.alice(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),

      //description
      labelLarge: const TextStyle(
          fontSize: 14, color: Colors.orange, fontWeight: FontWeight.w800),
    ),
    cardTheme: CardTheme(
        color: AppColors.bluecolur,
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))));
