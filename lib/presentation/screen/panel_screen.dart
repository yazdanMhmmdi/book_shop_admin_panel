import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/category_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/action_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/delete_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/main_panel.dart';
import 'package:book_shop_admin_panel/presentation/widget/post_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/search_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/show_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar_item.dart';
import 'package:flutter/material.dart';

class PanelScreen extends StatefulWidget {
  @override
  _PanelScreenState createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  bool _visiblity = false;
  double _padding = 0.0;
  double _opacity = 0.0;
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
                    children: [
                      SideBarItem(
                        child: Image.asset(Assets.add),
                        title: "افزودن",
                        onTap: () =>
                            ShowDialog.showDialog(context, PostDialog()),
                      ),
                      SideBarItem(
                        child: Image.asset(Assets.edit),
                        title: "ویرایش",
                        onTap: () =>
                            ShowDialog.showDialog(context, EditBookDialog()),
                      ),
                      SideBarItem(
                        child: Image.asset(Assets.delete),
                        title: "حذف",
                        onTap: () =>
                            ShowDialog.showDialog(context, DeleteBookDialog()),
                      ),
                      SideBarItem(
                        child: Image.asset(Assets.search),
                        title: "جستجو",
                        onTap: () {
                          setState(() {
                            if (_visiblity == false) {
                              _padding = 57.0;
                              _visiblity = true;
                              _opacity = 1.0;
                            } else {
                              _padding = 0.0;
                              _visiblity = false;
                              _opacity = 0.0;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                MainPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SearchFieldSpot(
                            visiblity: _visiblity,
                            opacity: _opacity,
                          ),
                          AnimatedPadding(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.only(top: _padding),
                              child: BooksTab()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
