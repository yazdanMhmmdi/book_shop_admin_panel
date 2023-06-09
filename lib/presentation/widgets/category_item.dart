// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import 'circular_double_tap.dart';

class CategoryItem extends StatelessWidget {
  Widget child;
  String title;
  Function? onTap;
  CategoryItem({super.key, required this.child, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Container(
        width: 148,
        height: 172,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: IColors.lowBoldGreen,
        ),
        child: CircularDoubleTap(
          onTap: () => onTap!.call(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
              const SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  color: IColors.black85,
                  fontFamily: Strings.fontIranSans,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
