// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/model/edaman.dart';

class SearchRecipeCardWidget extends StatelessWidget {
  final EdamamRecipeModel recipe;
  final BoxConstraints constraints;
  const SearchRecipeCardWidget({
    Key? key,
    required this.recipe,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight * 0.24,
      width: constraints.maxWidth,
      child: Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        elevation: 7,
        child: LayoutBuilder(builder: (context, columnCons) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AnimatedImageWidget(
                  screenConstraints: constraints,
                  columnConstraints: columnCons,
                  imageUrl: recipe.image),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AnimatedNameWidget(
                      screenConstraints: constraints,
                      columnConstraints: columnCons,
                      name: recipe.title),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}

class _AnimatedImageWidget extends StatelessWidget {
  final BoxConstraints screenConstraints;
  final BoxConstraints columnConstraints;
  final String imageUrl;
  const _AnimatedImageWidget({
    Key? key,
    required this.screenConstraints,
    required this.columnConstraints,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenConstraints.maxHeight * 0.2,
      width: screenConstraints.maxWidth * 0.4,
      margin: EdgeInsets.only(
          left: columnConstraints.maxWidth * 0.05,
          top: columnConstraints.maxHeight * 0.1),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.white12,
          highlightColor: Colors.white30,
          child: SizedBox(
              height: screenConstraints.maxHeight * 0.2,
              width: screenConstraints.maxWidth * 0.4,
              child: const Center(
                child: Icon(
                  Icons.restaurant,
                  size: 60,
                ),
              )),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ).animate(delay: 400.ms).shimmer(duration: 300.ms).flip();
  }
}

class _AnimatedNameWidget extends StatelessWidget {
  final BoxConstraints screenConstraints;
  final BoxConstraints columnConstraints;
  final String name;
  const _AnimatedNameWidget({
    Key? key,
    required this.screenConstraints,
    required this.columnConstraints,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenConstraints.maxWidth * 0.4,
      padding:
          EdgeInsets.only(top: 10, left: columnConstraints.maxWidth * 0.04),
      child: Text(name,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              softWrap: true,
              style: Theme.of(context).textTheme.titleLarge //title large
              )
          .animate()
          .fadeIn(duration: 300.ms, delay: 450.ms, curve: Curves.decelerate)
          .slideX(begin: 0.2, end: 0),
    );
  }
}
