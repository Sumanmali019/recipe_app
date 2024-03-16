// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedInfoWidget extends StatelessWidget {
  final Map<String, num> nutrition;
  final Duration infoDelayTime;
  final Duration infoPlayTime;
  final BoxConstraints constraints;
  const AnimatedInfoWidget({
    Key? key,
    required this.nutrition,
    required this.infoDelayTime,
    required this.infoPlayTime,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight * 0.1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xff182032),
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _InfoViewer(
            icon: Icons.monitor_heart,
            amount: "${nutrition["calories"]} cal",
          ),
          _InfoViewer(
            icon: Icons.people,
            amount: "${nutrition["Serving"]} person",
          ),
          _InfoViewer(
            icon: Icons.timer,
            amount: "${nutrition["prepTime"]} min",
          ),
        ]
            .animate(interval: 200.ms, delay: infoDelayTime + 400.ms)
            .fadeIn(duration: infoPlayTime, curve: Curves.decelerate)
            .scaleXY(begin: 0, end: 1),
      ),
    ).animate(delay: infoDelayTime).fadeIn(curve: Curves.decelerate);
  }
}

class _InfoViewer extends StatelessWidget {
  final IconData icon;
  final String amount;
  const _InfoViewer({
    Key? key,
    required this.icon,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          amount.toString(),
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontSize: 18, color: Colors.white),
        ),
        Icon(icon, color: Colors.white),
      ],
    );
  }
}
