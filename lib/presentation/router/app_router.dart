import 'package:book_shop_admin_panel/logic/bloc/side_bar_item_selector_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final TabsliderBloc _tabsliderBloc = new TabsliderBloc();

  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _tabsliderBloc),
                    BlocProvider(
                      create: (BuildContext context) =>
                          SideBarItemSelectorBloc(),
                    ),
                  ],
                  child: PanelScreen(
                    tabsliderBloc: _tabsliderBloc
                      ..add(MoveForwardEvent(tab: 0)),
                  ),
                ));
        break;

      default:
        return null;
    }
  }
}
