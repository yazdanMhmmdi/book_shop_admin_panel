import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/action_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/main_panel.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar.dart';
import 'package:flutter/material.dart';

class PanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lowBoldGreen,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            ActionBar(),
            Row(
              children: [
                SideBar(
                  child: Column(
                    children: [],
                  ),
                ),
                MainPanel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
