import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  Widget child = Text("C");
  ActionBar({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(height: 64, color: Colors.transparent);
  }
}
