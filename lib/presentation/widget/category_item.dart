import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/circular_double_tap.dart';
import 'package:book_shop_admin_panel/presentation/widget/circular_on_tap.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  Widget child;
  String title;
  CategoryItem({@required this.child, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Container(
        width: 148,
        height: 172,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: IColors.lowBoldGreen,
        ),
        child: CircularDoubleTap(
          onDoubleTap: () {
            print('Test2');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  color: IColors.black85,
                  fontFamily: "IranSans",
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
