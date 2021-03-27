import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/multi_text_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/text_field_spot.dart';
import 'package:flutter/material.dart';

import 'image_picker_spot.dart';

class EditBookDialog extends StatelessWidget {
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
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              children: [
                TextFieldSpot(
                  width: 377,
                  title: "نویسنده",
                ),
                SizedBox(width: 16),
                TextFieldSpot(
                  width: 377,
                  title: "موضوع کتاب",
                ),
              ],
            ),
            SizedBox(height: 16),
            MultiTextFieldSpot(
              title: "توضیحات",
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                TextFieldSpot(
                  width: 377,
                  title: "نوع جلد",
                ),
                SizedBox(width: 16),
                TextFieldSpot(
                  width: 377,
                  title: "زبان  ",
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                TextFieldSpot(
                  width: 377,
                  title: "رای  ",
                ),
                SizedBox(width: 16),
                TextFieldSpot(
                  width: 377,
                  title: "تعداد صفحات",
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ImagePickerSpot(),
            SizedBox(
              height: 8,
            ),
            Text(
              "اگر عکسی انتخاب نکنید عکس قبلی به عنوان پیش فرض قرار خواهد گرفت.",
              style: TextStyle(
                  color: IColors.black35,
                  fontSize: 14,
                  fontFamily: "IranSans",
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 38,
              width: 770,
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
                      "ثبت کتاب",
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
