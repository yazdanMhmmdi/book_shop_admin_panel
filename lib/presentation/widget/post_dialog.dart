import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/presentation/widget/post_custom_painter.dart';
import 'package:book_shop_admin_panel/presentation/widget/slider_object.dart';
import 'package:flutter/material.dart';

class PostDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 134,
              height: 111,
              child: CustomPaint(
                painter: PostCustomPainter(),
              ),
            ),
            Container(
              width: 737,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(38),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "جودی پیکلت",
                        style: TextStyle(
                          fontFamily: "IranSans",
                          fontSize: 16,
                          color: IColors.black35,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "کتاب دوراهی",
                        style: TextStyle(
                          fontFamily: "IranSans",
                          fontSize: 18,
                          color: IColors.black85,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SliderObject(
                          coverType: "null",
                          voteCount: "null",
                          pageCount: "null",
                          language: "null"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.postDialogdesc,
                            style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 20,
                              color: IColors.black85,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            Strings.lorem,
                            style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 16,
                              color: IColors.black35,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              height: 170,
              child: Image.asset(
                Assets.image_2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
