import 'package:book_shop_admin_panel/core/utils/typogaphy.dart';
import 'package:flutter/material.dart';

class WarningBarDesktop extends StatelessWidget {
  String text;
  WarningBarDesktop({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                Flexible(
                  child: Text(
                    text,
                    style: Typogaphy.Medium.copyWith(
                      fontFamily: "IranSans",
                      fontSize: 12,
                      color: Colors.red,
                      decoration: TextDecoration.none,
                    ),
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
