import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';

class BackgroundShapesDesktop extends StatefulWidget {
  const BackgroundShapesDesktop({super.key});

  @override
  State<BackgroundShapesDesktop> createState() =>
      _BackgroundShapesDesktopState();
}

class _BackgroundShapesDesktopState extends State<BackgroundShapesDesktop>
    with TickerProviderStateMixin {
  double width = 150;

  double height = 200;

  String heroTag = "background_shape";

  late final AnimationController _circleOneController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);

  late final AnimationController _circleTwoController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);

  late final AnimationController _circleThreeController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);

  late final AnimationController _circleFourController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);

  late Animation<Offset> circleOneAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.12, 0.12),
  ).animate(_circleOneController);

  late Animation<Offset> circleTwoAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-0.4, -0.22),
  ).animate(_circleTwoController);

  late Animation<Offset> circleThreeAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.4, 0.12),
  ).animate(_circleThreeController);

  late Animation<Offset> circleFourAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.12, 0.12),
  ).animate(_circleOneController);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              child: SlideTransition(
                  position: circleOneAnimation,
                  child: Image.asset(Assets.circle_1))),
          Positioned(
              bottom: 0,
              right: 0,
              child: SlideTransition(
                  position: circleTwoAnimation,
                  child: Image.asset(Assets.circle_2))),
          Positioned(
              top: 12,
              left: 12,
              child: SlideTransition(
                  position: circleThreeAnimation,
                  child: Image.asset(Assets.circle_3))),
          Positioned(
              top: 0,
              right: 0,
              child: SlideTransition(
                  position: circleFourAnimation,
                  child: Image.asset(Assets.circle_4))),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _circleOneController.dispose();
    _circleTwoController.dispose();
    _circleThreeController.dispose();
    _circleFourController.dispose();
    super.dispose();
  }
}
