import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/tab/users_tab.dart';
import 'package:flutter/material.dart';

class TopRightUserWidget extends StatelessWidget {
  String id;
  int number;
  TopRightUserWidget({@required this.id, @required this.number});
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      width: 26,
      height: 26,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: UsersTab.clickStatus == number
              ? IColors.boldGreen
              : IColors.green),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            color: UsersTab.clickStatus == number
                ? Colors.white70
                : IColors.black85,
            fontFamily: "IranSans",
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          child: Text(
            '23',
          ),
        ),
      ),
    );
  }
}
