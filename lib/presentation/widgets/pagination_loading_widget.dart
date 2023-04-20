import 'package:book_shop_admin_panel/core/constants/i_colors.dart';
import 'package:flutter/material.dart';

class PaginationLoadingWidget extends StatelessWidget {
  const PaginationLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: IColors.boldGreen,
    );
  }
}
