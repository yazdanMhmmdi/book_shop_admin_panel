import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class CircularDoubleTap extends StatelessWidget {
  Widget child;
  Function onDoubleTap;
  CircularDoubleTap({@required this.child, @required this.onDoubleTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: IColors.black15,
        borderRadius: BorderRadius.circular(18),
        onDoubleTap: onDoubleTap,
        child: child,
      ),
    );
  }
}
