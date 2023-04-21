import '../../core/constants/i_colors.dart';
import 'package:flutter/material.dart';

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
