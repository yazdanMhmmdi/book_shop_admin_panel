import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/presentation/widget/circular_on_tap.dart';
import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  Widget child;
  String title;
  Function onTap;
  SideBarItem({this.child, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 22),
        CircularOnTap(
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                child: child,
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: IColors.black85,
                  fontFamily: Strings.fontIranSans,
                ),
              ),
            ],
          ),
          onTap: onTap,
        )
      ],
    );
  }
}
