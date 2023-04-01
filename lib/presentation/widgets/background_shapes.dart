import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';

class BackgroundShapes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 9,
            left: 18,
            child: Image.asset(
              Assets.circle_1,
            )),
        Positioned(
          child: Image.asset(Assets.circle_2),
          top: 62,
          right: 0,
        ),
        Positioned(
          child: Image.asset(Assets.circle_3),
          bottom: 0,
          left: 0,
        ),
        Positioned(
          child: Image.asset(Assets.circle_4),
          bottom: 32,
          right: 29,
        )
      ],
    );
  }
}
