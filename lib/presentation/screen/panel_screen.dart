import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/logic/bloc/side_bar_item_selector_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/category_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/users_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/action_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/custom_tab_slider.dart';
import 'package:book_shop_admin_panel/presentation/widget/delete_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_user_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/main_panel.dart';
import 'package:book_shop_admin_panel/presentation/widget/post_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/search_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/show_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar_item.dart';
import 'package:book_shop_admin_panel/presentation/widget/title_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<TitleSelectorState> cartKey = GlobalKey();

class PanelScreen extends StatefulWidget {
  TabsliderBloc tabsliderBloc;

  static bool visiblity = false;
  static double padding = 0.0;
  static double opacity = 0.0;
  PanelScreen({@required this.tabsliderBloc});
  @override
  _PanelScreenState createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  int tab;
  SideBarItemSelectorBloc _sideBarItemSelectorBloc;

  @override
  void initState() {
    _sideBarItemSelectorBloc =
        BlocProvider.of<SideBarItemSelectorBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabsliderBloc, TabsliderState>(
      listener: (context, state) {
        if (state is TabsliderInitial) {
          return Container();
        } else if (state is TabsliderSuccess) {
          if (state.tab is UsersTab) {
            print('UsersTab');
          }
          if (state.tab is BooksTab) {
            print('BooksTab');
          }
          _sideBarItemSelectorBloc
              .add(SelectItemEvent(currentTab: state.tab, context: context));
          return Container();
        }
      },
      child: Scaffold(
        backgroundColor: IColors.lowBoldGreen,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              ActionBar(
                tabsliderBloc: widget.tabsliderBloc,
              ),
              Row(
                children: [
                  SideBar(child: BlocBuilder<SideBarItemSelectorBloc,
                      SideBarItemSelectorState>(
                    builder: (context, state) {
                      if (state is SideBarItemSelectorInitial) {
                        return Container();
                      } else if (state is SideBarItemSelectorSuccess) {
                        return state.items;
                      }
                    },
                  )),
                  MainPanel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SearchFieldSpot(
                              visiblity: PanelScreen.visiblity,
                              opacity: PanelScreen.opacity,
                            ),
                            AnimatedPadding(
                                duration: Duration(milliseconds: 300),
                                padding:
                                    EdgeInsets.only(top: PanelScreen.padding),
                                child:
                                    BlocBuilder<TabsliderBloc, TabsliderState>(
                                  builder: (context, state) {
                                    if (state is TabsliderInitial) {
                                      return Container();
                                    } else if (state is TabsliderSuccess) {
                                      return state.tab;
                                    }
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
