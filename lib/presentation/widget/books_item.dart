import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/image_holder.dart';
import 'package:book_shop_admin_panel/presentation/widget/top_right_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'regular_item_bar.dart';

class BooksItem extends StatelessWidget {
  Widget image;
  String title, writer;
  double rate;
  String id;
  BooksItem({
    @required this.image,
    @required this.title,
    @required this.writer,
    @required this.rate,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, bottom: 26),
      child: Container(
        width: 143,
        height: 253,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: IColors.lowBoldGreen,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TopRightWidget(
                id: id,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ImageHolder(
              child: image,
            ),
            SizedBox(height: 16),
            Text(
              "${title}",
              style: TextStyle(
                fontFamily: "IranSans",
                fontSize: 16,
                color: IColors.black85,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${writer}",
              style: TextStyle(
                fontFamily: "IranSans",
                fontSize: 14,
                color: IColors.black35,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            RegularRatingBar(
              rate: rate,
            ),
          ],
        ),
      ),
    );
  }
}
