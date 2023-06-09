// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DetailSliderItem extends StatelessWidget {
  late String title, subTitle;
  DetailSliderItem({super.key, required this.title, required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: "iranSans",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
              fontFamily: "iranSans", fontSize: 18, color: Colors.black38),
        )
      ],
    );
  }
}
