import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recepi_application/presentation/home/home_widget/recepi_shimmer_card.dart';

class ShimmerLoadingList extends StatelessWidget {
  final BoxConstraints constraints;
  const ShimmerLoadingList({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return RecipeShimmerCard(constraints: constraints).animate().slideY(
              duration: 350.ms, begin: 1, end: 0, curve: Curves.easeInOutSine);
        });
  }
}
