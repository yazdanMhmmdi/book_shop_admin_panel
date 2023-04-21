import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';

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
