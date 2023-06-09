// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';

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
