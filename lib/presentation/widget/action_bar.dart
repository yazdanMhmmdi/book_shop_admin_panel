import 'package:flutter/material.dart';

import 'custom_tab_slider.dart';

class ActionBar extends StatelessWidget {
  Widget child = Text("C");
  ActionBar({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: CustomTabSlider(),
    );
  }
}
