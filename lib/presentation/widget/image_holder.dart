import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class ImageHolder extends StatelessWidget {
  String address;
  ImageHolder({@required this.address});

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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(address),
      ),
    );
  }
}
