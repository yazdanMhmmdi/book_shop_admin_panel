// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';

class MainPanel extends StatelessWidget {
  Widget? child = Text("B");
  MainPanel({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 65,
      width: MediaQuery.of(context).size.width-77,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(38), topLeft: Radius.circular(38)),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, -1),
              blurRadius: 4.0,
              spreadRadius: 0,
              color: IColors.black15,
            )
          ]),
      child: child,
    );
  }
}
