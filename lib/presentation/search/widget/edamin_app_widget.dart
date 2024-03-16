import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class EdaminanimatedAppBarWidget extends StatelessWidget {
  final String name;
  final Duration appBarPlayTime;
  final Duration appBarDelayTime;
  const EdaminanimatedAppBarWidget({
    Key? key,
    required this.name,
    required this.appBarPlayTime,
    required this.appBarDelayTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 22,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Expanded(
          flex:
              2, // Give the text widget twice the space compared to the icon button.
          child: Text(
            name.toUpperCase(),
            textAlign: TextAlign.center, // Center align the text.
            style: GoogleFonts.alice(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
        ),
        Expanded(
          child:
              Container(), // Placeholder to balance the row and keep the text centered.
        ),
      ].animate(interval: 200.ms, delay: appBarDelayTime).scaleXY(
          begin: 0, end: 1, duration: appBarPlayTime, curve: Curves.decelerate),
    );
  }
}
