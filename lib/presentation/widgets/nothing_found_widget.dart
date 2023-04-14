import 'package:book_shop_admin_panel/core/constants/i_colors.dart';
import 'package:flutter/material.dart';

class NothingFoundWidget extends StatelessWidget {
  const NothingFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "کتابی در این رابطه پیدا نشد.",
          style: TextStyle(color: IColors.black55, fontSize: 16),
        ),
      ),
    );
  }
}
