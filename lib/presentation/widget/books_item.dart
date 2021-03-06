import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/image_holder.dart';
import 'package:book_shop_admin_panel/presentation/widget/top_right_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'regular_item_bar.dart';

class BooksItem extends StatelessWidget {
  String image;
  String title, writer;
  double rate;
  String id;
  int number;
  Function onTap;
  Function onDoubleTap;
  BooksItem({
    @required this.image,
    @required this.title,
    @required this.writer,
    @required this.rate,
    @required this.id,
    @required this.number,
    @required this.onTap,
    @required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, bottom: 26),
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 300,
        ),
        width: 125,
        height: 247,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: BooksTab.clickStatus == number
              ? IColors.green
              : IColors.lowBoldGreen,
          boxShadow: BooksTab.clickStatus == number
              ? [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 30,
                    spreadRadius: -2,
                    color: IColors.boldGreen75,
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // splashFactory: InkRipple.splashFactory,
            borderRadius: BorderRadius.circular(8),
            splashColor: IColors.black15,
            onTap: onTap,
            onLongPress: onDoubleTap,
            // doubleTapTime: Duration(milliseconds: 300),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TopRightBookWidget(
                    id: id,
                    number: number,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ImageHolder(
                  address: image,
                ),
                SizedBox(height: 12),
                Container(
                  width: 95,
                  child: Text(
                    "${title}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Strings.fontIranSans,
                      fontSize: 16,
                      color: IColors.black85,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 95,
                  child: Text(
                    "${writer}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: Strings.fontIranSans,
                      fontSize: 14,
                      color: IColors.black35,
                    ),
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
        ),
      ),
    );
  }
}
