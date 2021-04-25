import 'dart:async';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldSpot extends StatefulWidget {
  String title;
  double width;
  int maxLengh;
  String initialValue;
  Function(dynamic) onChanged;
  TextFieldSpot(
      {@required this.title,
      @required this.width,
      @required this.maxLengh,
      @required this.onChanged,
      @required this.initialValue});

  @override
  _TextFieldSpotState createState() => _TextFieldSpotState();
}

class _TextFieldSpotState extends State<TextFieldSpot> {
  String value;
  final controller = TextEditingController();

  @override
  void initState() {
    print("textField: ${widget.initialValue}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    widget.initialValue = "";
    controller.clear();

    controller.dispose();
    super.dispose();
  }
}
