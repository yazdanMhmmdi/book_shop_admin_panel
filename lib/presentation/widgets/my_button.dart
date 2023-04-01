import 'dart:async';

import 'package:book_shop_admin_panel/presentation/widgets/progress_button.dart';
import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';

class MyButton extends StatefulWidget {
  String text;
  Function onTap;
  var buttonState = ButtonState.idle;

  void runAnimation(var state) {
    if (state == ButtonState.loading) {
    } else if (state == ButtonState.success) {
    } else if (state == ButtonState.fail) {
    } else if (state == ButtonState.idle) {}
  }

  MyButton(
      {required this.text, required this.onTap, required this.buttonState});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  double buttonRadius = 8.0;
  double? maxWidth;
  bool maxWidthFlag = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (maxWidthFlag) {
        maxWidth = MediaQuery.of(context).size.width;
        maxWidthFlag = false;
      }
    });
    return MyProgressButton(
      minWidth: 50.0,
      height: 46.0,
      maxWidth: maxWidth!,
      radius: buttonRadius,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      stateWidgets: {
        ButtonState.idle: Text(
          "${widget.text}",
          style: TextStyle(
              color: Colors.white,
              fontFamily: Strings.fontIranSans,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        ButtonState.loading: Container(),
        ButtonState.fail: Icon(
          Icons.close,
          color: Colors.white,
        ),
        ButtonState.success: Icon(
          Icons.check,
          color: Colors.white,
        )
      },
      stateColors: {
        ButtonState.idle: IColors.boldGreen,
        ButtonState.loading: IColors.boldGreen,
        ButtonState.fail: IColors.boldGreen,
        ButtonState.success: IColors.boldGreen,
      },
      onPressed: () {
        // setState(() {
        //   buttonState = widget.onTap(); //asdsadsdd
        // });
        widget.onTap();
        // else if (widget.buttonState == ButtonState.idle) {
        //   setState(() {
        //     widget.buttonState = ButtonState.idle;
        //     buttonRadius = 8;
        //     maxWidth = MediaQuery.of(context).size.width;
        //   });
        // } else if (widget.buttonState == ButtonState.success) {
        //   setState(() {
        //     widget.buttonState = ButtonState.success;
        //     buttonRadius = 100;
        //     maxWidth = 50.0;
        //   });
        // }
      },
      state: widget.buttonState,
    );
  }
}
