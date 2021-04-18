import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/side_bar_item_selector_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/presentation/screen/login_screen.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/tab/category_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final TabsliderBloc _tabsliderBloc = new TabsliderBloc();
  final BookBloc _bookBloc = new BookBloc();
  final UsersBloc _usersBloc = new UsersBloc();
  //final UsersBloc _usersBloc = new UsersBloc();
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
                    BlocProvider.value(value: _bookBloc),
                    BlocProvider.value(value: _usersBloc),
                  ],
                  child: LoginScreen(),
                  // PanelScreen(
                  //   tabsliderBloc: _tabsliderBloc
                  //     ..add(MoveForwardEvent(
                  //         tab: 0,
                  //         tabSliderBloc: _tabsliderBloc,
                  //         bookBloc: _bookBloc,
                  //         usersBloc: _usersBloc,
                  //         orginalTab: CategoryTab())),
                  // ),
                ));
        break;

      default:
        return null;
    }
  }
}
