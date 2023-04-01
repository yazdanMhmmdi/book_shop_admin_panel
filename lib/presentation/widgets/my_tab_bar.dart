import 'package:book_shop_admin_panel/presentation/widgets/circular_indicator.dart';
import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';

class MyTabBar extends StatefulWidget {
  Widget? child = Text("C");
  TabController tabController;
  MyTabBar({this.child, required this.tabController});

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, right: 64),
      child: Container(
        height: 64,
        width: MediaQuery.of(context).size.width,
        color: IColors.lowBoldGreen,
        child: _tabBar(),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      labelColor: IColors.black85,
      indicator: CircularIndicator(color: Colors.black87, radius: 4),
      labelStyle: const TextStyle(
        fontSize: 22,
        fontFamily: "IranSans",
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontFamily: "IranSans",
        fontWeight: FontWeight.w700,
      ),
      controller: widget.tabController,
      tabs: [
        Tab(
          text: Strings.tabBooks,
        ),
        Tab(
          text: Strings.tabUsers,
        ),
      ],
    );
  }
}
