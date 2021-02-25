import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/category_item.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "موضوعات",
              style: TextStyle(
                  color: IColors.black85,
                  fontSize: 20,
                  fontFamily: "IranSans",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 26),
            Row(
              children: [
                CategoryItem(
                  child: Image.asset(Assets.labTool),
                  title: "علمی",
                ),
                CategoryItem(
                  child: Image.asset(Assets.medicine),
                  title: "دارویی",
                ),
                CategoryItem(
                  child: Image.asset(Assets.hourglass),
                  title: "تاریخی",
                ),
                CategoryItem(
                  child: Image.asset(Assets.auction),
                  title: "قضایی",
                ),
                CategoryItem(
                  child: Image.asset(Assets.dish),
                  title: "غذایی",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
