import 'package:book_shop_admin_panel/core/utils/typogaphy.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class ToastWidget {
  ToastWidget._();
  static showWarning(context, {required String title, required String desc}) {
    MotionToast.warning(
      layoutOrientation: ToastOrientation.rtl,
      position: MotionToastPosition.bottom,
      animationType: AnimationType.fromBottom,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text("${title}",
            style: Typogaphy.Bold.copyWith(
              fontSize: 14,
            )),
      ),
      description: Text(
        "${desc}",
        style: Typogaphy.Medium.copyWith(
          fontSize: 12,
        ),
      ),
    ).show(context);
  }
}