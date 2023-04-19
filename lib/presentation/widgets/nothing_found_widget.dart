import 'package:book_shop_admin_panel/core/constants/i_colors.dart';
import 'package:book_shop_admin_panel/core/utils/typogaphy.dart';
import 'package:flutter/material.dart';

class NothingFoundWidget extends StatelessWidget {
  const NothingFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text("آیتمی در این رابطه پیدا نشد.",
            style: Typogaphy.Medium.copyWith(fontSize: 14,
            color: IColors.black55
            )),
      ),
    );
  }
}
