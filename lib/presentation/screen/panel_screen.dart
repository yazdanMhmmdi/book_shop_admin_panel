import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/main_panel.dart';
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
            Container(height: 64, color: Colors.blue),
            Row(
              children: [
                Container(
                  width: 77,
                  height: MediaQuery.of(context).size.height - 64,
                  color: Colors.yellow,
                  child: Text('a'),
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
