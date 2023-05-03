import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import 'detail_slider_item.dart';

class DetailSliderContainer extends StatelessWidget {
  List<DetailSliderItem> detailSliderItems;
  DetailSliderContainer({required this.detailSliderItems});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: IColors.boldGreen.withOpacity(0.15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: detailSliderItems,
            ),
          ),
        ),
      );
    });
  }
}
