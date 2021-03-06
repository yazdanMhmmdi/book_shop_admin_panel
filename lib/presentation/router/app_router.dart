import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/chat_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/chatlist_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/login_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/side_bar_item_selector_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/logic/cubit/internet_cubit.dart';
import 'package:book_shop_admin_panel/presentation/screen/login_screen.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/tab/category_tab.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final TabsliderBloc _tabsliderBloc = new TabsliderBloc();
  final ChatBloc _chatBloc= new ChatBloc();
  final BookBloc _bookBloc = new BookBloc();
  final UsersBloc _usersBloc = new UsersBloc();
  final ChatlistBloc _chatlistBloc = new ChatlistBloc();
  final InternetCubit _internetCubit =
      new InternetCubit(connectivity: Connectivity());
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _internetCubit),
                    BlocProvider(create: (context) => LoginBloc()),
                  ],
                  child: LoginScreen(),
                ));
      case "/panel":
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
                    BlocProvider.value(value: _internetCubit),
                    BlocProvider.value(value: _chatlistBloc),
                    BlocProvider.value(value: _chatBloc),

                  ],
                  child: PanelScreen(
                    tabsliderBloc: _tabsliderBloc
                      ..add(MoveForwardEvent(
                          tab: 0,
                          tabSliderBloc: _tabsliderBloc,
                          bookBloc: _bookBloc,
                          usersBloc: _usersBloc,
                          orginalTab: CategoryTab())),
                  ),
                ));
        break;

      default:
        return null;
    }
  }
}
