import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class TopRightWidget extends StatelessWidget {
  String id;
  TopRightWidget({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: IColors.green),
      child: Center(
        child: Text(
          '23',
          style: TextStyle(
            color: IColors.black85,
            fontFamily: "IranSans",
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
