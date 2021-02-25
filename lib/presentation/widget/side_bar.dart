import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  Widget child = Text('A');
  SideBar({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 77,
      height: MediaQuery.of(context).size.height - 64,
      color: Colors.transparent,
      child: child,
    );
  }
}
