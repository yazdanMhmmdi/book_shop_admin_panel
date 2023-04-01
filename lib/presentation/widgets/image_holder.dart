import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';

class ImageHolder extends StatelessWidget {
  String address;
  ImageHolder({required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 81,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(7, 7),
              blurRadius: 10.0,
              spreadRadius: 0,
              color: IColors.black15,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(address),
              fit: BoxFit.cover,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
