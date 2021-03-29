import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:flutter/material.dart';

import 'custom_tab_slider.dart';

class ActionBar extends StatefulWidget {
  Widget child = Text("C");
  TabsliderBloc tabsliderBloc;
  ActionBar({this.child, @required this.tabsliderBloc});

  @override
  _ActionBarState createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: CustomTabSlider(
        tabsliderBloc: widget.tabsliderBloc,
      ),
    );
  }
}
