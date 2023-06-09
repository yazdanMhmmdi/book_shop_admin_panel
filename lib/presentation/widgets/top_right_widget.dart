// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/utils/typogaphy.dart';

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
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: IColors.green),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: Typogaphy.Bold.copyWith(fontSize: 14),
          child: Text(
            '${id}',
          ),
        ),
      ),
    );
  }
}
