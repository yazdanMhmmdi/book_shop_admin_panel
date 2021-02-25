import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  Widget child;
  String title;
  SideBarItem({this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 26),
        Container(
          width: 45,
          height: 45,
          child: child,
        ),
        SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}
