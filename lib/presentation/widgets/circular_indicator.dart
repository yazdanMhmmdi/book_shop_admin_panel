// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CircularIndicator extends Decoration {
  Color color;
  double radius;
  CircularIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BoxCircle(color: color, radius: radius);
  }
}

class _BoxCircle extends BoxPainter {
  double radius;
  Color color;
  _BoxCircle({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circularOffset = Offset(
        configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(offset + circularOffset, radius, _paint);
  }
}
