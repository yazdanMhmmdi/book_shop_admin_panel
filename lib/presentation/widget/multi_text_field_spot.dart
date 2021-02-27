import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class MultiTextFieldSpot extends StatelessWidget {
  String title;
  MultiTextFieldSpot({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: "IranSans",
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 35,
          width: 770,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: IColors.lowBoldGreen,
          ),
        ),
      ],
    );
  }
}
