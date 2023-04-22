import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: CircularProgressIndicator(
          color: IColors.boldGreen,
        )));
  }
}
