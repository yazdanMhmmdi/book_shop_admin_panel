// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRatingBar extends StatelessWidget {
  double voteCount;
  double itemSize;
  MyRatingBar(this.voteCount, this.itemSize);
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: itemSize,
      initialRating: voteCount,
      minRating: 1,
      direction: Axis.horizontal,
      ignoreGestures: true,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
