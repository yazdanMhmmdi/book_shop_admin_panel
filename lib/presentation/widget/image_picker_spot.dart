import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class ImagePickerSpot extends StatelessWidget {
  const ImagePickerSpot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 131,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: IColors.lowBoldGreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "انتخاب عکس",
            style: TextStyle(
              fontFamily: "IranSans",
              fontSize: 16,
              color: IColors.black85,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 16,
              height: 16,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
