import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class MainPanel extends StatelessWidget {
  Widget child = Text("B");
  MainPanel({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 77,
      height: MediaQuery.of(context).size.height - 64,
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
