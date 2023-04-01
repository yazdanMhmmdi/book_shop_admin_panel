import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RegularRatingBar extends StatelessWidget {
  double rate;
  RegularRatingBar({required this.rate});
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 12,
      initialRating: rate,
      minRating: 1,
      direction: Axis.horizontal,
      ignoreGestures: true,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
