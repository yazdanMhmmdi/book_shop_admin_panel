import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class CircularOnTap extends StatelessWidget {
  Widget child;
  CircularOnTap({@required this.child, @required this.onTap});
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: IColors.black15,
        borderRadius: BorderRadius.circular(10),
        child: child,
        onTap: onTap,
      ),
    );
  }
}
