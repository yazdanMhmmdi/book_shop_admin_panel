import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiTextFieldSpot extends StatelessWidget {
  String title;
  int maxLengh = 100;
  String initialValue;

  Function(String) onChanged;
  MultiTextFieldSpot(
      {@required this.title,
      @required this.maxLengh,
      @required this.onChanged,
      this.initialValue});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
