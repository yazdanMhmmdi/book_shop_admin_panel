import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/books_item.dart';
import 'package:flutter/material.dart';

class TopRightBookWidget extends StatelessWidget {
  String id;
  int number;
  TopRightBookWidget({@required this.id, @required this.number});

  @override
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
          color: BooksTab.clickStatus == number
              ? IColors.boldGreen
              : IColors.green),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            color: BooksTab.clickStatus == number
                ? Colors.white70
                : IColors.black85,
            fontFamily: Strings.fontIranSans,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          child: Text(
            '${id}',
          ),
        ),
      ),
    );
  }
}
