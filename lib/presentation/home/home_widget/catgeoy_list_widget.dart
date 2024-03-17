// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const_assets/theme/app_colors.dart';

// Replace with your actual color or import from your colors file.
const Color primaryColor = Colors.teal;

// ignore: must_be_immutable
class FoodCategoryWidget extends StatelessWidget {
  String? imageUrl;
  final String name;
  final bool isSelected;
  FoodCategoryWidget({
    Key? key,
    this.imageUrl,
    required this.name,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.bluecolur : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                name,
                maxLines: 2,
                style: GoogleFonts.alice(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: ClipRRect(
              child: Image.asset(
                imageUrl!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20); // Start from the top left corner

    // Draw the wavy part
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // Finish the path by drawing a line to the bottom right corner
    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
