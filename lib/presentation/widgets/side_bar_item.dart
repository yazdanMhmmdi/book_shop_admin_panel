// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import 'circle_on_tap.dart';

class SideBarItem extends StatelessWidget {
  Widget? child;
  String? title;
  Function? onTap;
  SideBarItem({this.child, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 22),
        CircularOnTap(
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                child: child,
              ),
              SizedBox(height: 5),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 16,
                  color: IColors.black85,
                  fontFamily: Strings.fontIranSans,
                ),
              ),
            ],
          ),
          onTap: () => onTap!.call(),
        )
      ],
    );
  }
}
