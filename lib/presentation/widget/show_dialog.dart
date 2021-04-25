import 'package:flutter/material.dart';


class ShowDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  static showDialog(BuildContext context, Widget dialog) {
    return showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: dialog,
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
          child: child,
        );
      },
    );
  }
}