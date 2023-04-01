import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';

class TopRightBookWidget extends StatelessWidget {
  String id;
  int number;
  TopRightBookWidget({required this.id, required this.number});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      width: 26,
      height: 26,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: IColors.green),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            color: Colors.white70,
            fontFamily: Strings.fontIranSans,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          child: Text(
            '${id}',
          ),
        ),
      ),
    );
  }
}
