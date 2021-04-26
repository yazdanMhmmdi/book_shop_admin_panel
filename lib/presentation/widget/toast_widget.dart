import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'لطفا یک ایتم را برای حذف کردن انتخاب کنید',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "IranSans",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: IColors.white90,
          ),
        ),
      ),
    );
  }
}
