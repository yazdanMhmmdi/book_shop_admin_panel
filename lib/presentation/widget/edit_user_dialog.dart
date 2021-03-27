import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/text_field_spot.dart';
import 'package:flutter/material.dart';

class EditUserDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, -1),
              blurRadius: 4,
              spreadRadius: 0,
              color: IColors.black15,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldSpot(
              width: 660,
              title: "نام کاربری",
            ),
            TextFieldSpot(
              width: 660,
              title: "رمز عبور",
            ),
            SizedBox(height: 16,),
            Container(
              height: 38,
              width: 660,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: IColors.boldGreen,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "ویرایش کاربر",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "IranSans",
                          fontSize: 16,
                          color: Colors.white70,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
