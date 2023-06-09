// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

import '../../core/constants/i_colors.dart';

class ImageHolder extends StatelessWidget {
  String address;
  String? blurhash = "";
  ImageHolder({
    required this.address,
    required this.blurhash,
  });

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: OctoImage(
            image: CachedNetworkImageProvider(address),
            placeholderBuilder: OctoPlaceholder.blurHash(
              blurhash!,
            ),
            errorBuilder: OctoError.icon(color: Colors.red),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
