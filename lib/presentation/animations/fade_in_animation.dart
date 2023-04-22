import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../core/constants/constants.dart';

enum _AniProps { opacity, translateX }

class FadeInAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeInAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(
        _AniProps.opacity,
        0.0.tweenTo(1.0),
        const Duration(milliseconds: kAnimationDuration),
        Curves.easeInOut,
      )
      ..add(
        _AniProps.translateX,
        60.0.tweenTo(0.0),
        const Duration(milliseconds: kAnimationDuration),
        Curves.easeInOut,
      );

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: (kAnimationDuration * delay).round().milliseconds,
      duration: const Duration(milliseconds: kAnimationDuration),
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(_AniProps.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}
