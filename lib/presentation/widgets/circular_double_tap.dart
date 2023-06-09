// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';

class CircularDoubleTap extends StatelessWidget {
  Widget child;
  Function onTap;
  CircularDoubleTap({super.key, required this.child, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: IColors.black15,
        borderRadius: BorderRadius.circular(18),
        onTap: () => onTap.call(),
        child: child,
      ),
    );
  }
}
