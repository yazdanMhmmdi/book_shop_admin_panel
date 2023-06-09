// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../core/utils/typogaphy.dart';

class WarningBarMobile extends StatelessWidget {
  String text;
  WarningBarMobile({required this.text});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerRight,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  text,
                  style: Typogaphy.Light.copyWith(
                    fontFamily: "IranSans",
                    fontSize: 14,
                    color: Colors.red,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
