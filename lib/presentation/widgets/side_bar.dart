import 'package:book_shop_admin_panel/core/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widgets/side_bar_item.dart';
import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';

class SideBar extends StatelessWidget {
  List<Widget>? children;
  SideBar({Key? key,required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 77,
        color: IColors.lowBoldGreen,
        child: Column(
          children: children!,
        ),
      ),
    );
  }
}
