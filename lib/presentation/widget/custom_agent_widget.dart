import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class CustomerAgentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 7, offset: Offset(7, 7), color: IColors.balck15),
          ]),
      child: Center(
        child: Image.asset(
          Assets.customerAgent,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
