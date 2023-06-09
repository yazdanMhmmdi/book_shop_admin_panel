// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../global_class.dart';
import '../top_right_widget.dart';

class UserItemDesktop extends StatelessWidget {
  int number;
  Function onTap;
  String name, username;
  String id;
  UserItemDesktop({
    required this.number,
    required this.onTap,
    required this.name,
    required this.username,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 145,
        height: 179,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: GlobalClass.pickedUserId == number
              ? IColors.green
              : IColors.lowBoldGreen,
          boxShadow: GlobalClass.pickedUserId == number
              ? [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 30,
                    spreadRadius: -2,
                    color: IColors.boldGreen75,
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: IColors.black15,
            onTap: () => onTap.call(),
            child: Column(
              children: [
                Align(
                  child: TopRightBookWidget(
                    id: id,
                    number: number,
                  ),
                  alignment: Alignment.topRight,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        offset: Offset(7, 7),
                        color: IColors.black15)
                  ]),
                  child: Image.asset(
                    Assets.user_ico,
                    width: 64,
                    height: 64,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 94,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: IColors.black85,
                      fontFamily: Strings.fontIranSans,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 94,
                  child: Text(
                    username,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: IColors.black35,
                      fontFamily: Strings.fontIranSans,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
