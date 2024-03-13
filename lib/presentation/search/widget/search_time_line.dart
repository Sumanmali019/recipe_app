// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recepi_application/domain/model/edaman.dart';
import 'package:recepi_application/presentation/search/widget/search_sliding_panel.dart';

class SearchTimeLineSlidingPanel extends StatefulWidget {
  final EdamamRecipeModel recipe;
  final Widget body;
  final BoxConstraints constraints;
  const SearchTimeLineSlidingPanel({
    Key? key,
    required this.recipe,
    required this.body,
    required this.constraints,
  }) : super(key: key);

  @override
  State<SearchTimeLineSlidingPanel> createState() =>
      _TimeLineSlidingPanelState();
}

class _TimeLineSlidingPanelState extends State<SearchTimeLineSlidingPanel>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final CurvedAnimation _curvedAnimation;
  late final AnimationController _ingridController;
  final baseDelayTime = 2000.ms;
  final slidingDuration = 600.ms;

  @override
  void initState() {
    initializeControllers();
    playAnimations();
    super.initState();
  }

  void initializeControllers() {
    _ingridController = AnimationController(vsync: this);
    _controller = AnimationController(vsync: this, duration: slidingDuration);
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
    _animation = Tween<double>(begin: 0, end: 0.4).animate(_curvedAnimation);
  }

  void playAnimations() {
    Future.delayed(baseDelayTime, () {
      _controller.forward();
    });
    Future.delayed(baseDelayTime + 400.ms, () => _ingridController.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    _curvedAnimation.dispose();
    _ingridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnimatedSlidingPanel(
        recipe: widget.recipe,
        body: widget.body,
        constraints: widget.constraints,
        ingredientController: _ingridController,
        baseDelayTime: baseDelayTime,
        slidingDuration: slidingDuration,
        listenable: _animation);
  }
}
