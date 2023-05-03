import '../../../core/utils/typogaphy.dart';
import '../top_right_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../image_holder.dart';
import '../regular_item_bar.dart';

class BooksItemDesktop extends StatelessWidget {
  String image;
  String title, writer;
  String blurhash;
  double rate;
  String id;
  int number;
  Function onTap;
  Function onDoubleTap;
  bool selected;
  BooksItemDesktop({
    super.key,
    required this.image,
    required this.title,
    required this.writer,
    required this.rate,
    required this.id,
    required this.number,
    required this.onTap,
    required this.onDoubleTap,
    required this.selected,
    required this.blurhash,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, bottom: 26),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        width: 125,
        height: 247,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? IColors.green : IColors.lowBoldGreen,
          boxShadow: selected
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
            // splashFactory: InkRipple.splashFactory,
            borderRadius: BorderRadius.circular(8),
            splashColor: IColors.black15,
            onTap: () => onTap.call(),
            onLongPress: () => onDoubleTap,
            // doubleTapTime: Duration(milliseconds: 300),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TopRightBookWidget(
                    id: id,
                    number: number,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ImageHolder(
                  address: image,
                  blurhash: blurhash,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 95,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Typogaphy.Bold.copyWith(
                      fontFamily: Strings.fontIranSans,
                      fontSize: 14,
                      color: IColors.black85,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 95,
                  child: Text(writer,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Typogaphy.Medium.copyWith(
                        fontFamily: Strings.fontIranSans,
                        fontSize: 12,
                        color: IColors.black35,
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
                RegularRatingBar(
                  rate: rate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
