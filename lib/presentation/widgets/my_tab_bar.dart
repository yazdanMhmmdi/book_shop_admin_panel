// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';

class MyTabBar extends StatefulWidget {
  TabController tabController;
  MyTabBar({required this.tabController});

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
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      color: IColors.lowBoldGreen,
    );
  }
}
