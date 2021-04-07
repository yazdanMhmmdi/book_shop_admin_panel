import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/logic/bloc/category_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/side_bar_item_selector_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
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
  PanelScreen({@required this.tabsliderBloc});
  @override
  _PanelScreenState createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  int tab;
  ScrollController scrollController;

  SideBarItemSelectorBloc _sideBarItemSelectorBloc;
  CategoryBloc _categoryBloc;
  UsersBloc _usersBloc;
  bool visiblity = false;
  double padding = 0.0;
  double opacity = 0.0;
  @override
  void initState() {
    _sideBarItemSelectorBloc =
        BlocProvider.of<SideBarItemSelectorBloc>(context);
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    scrollController = new ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabsliderBloc, TabsliderState>(
      listener: (context, state) {
        if (state is TabsliderInitial) {
          return Container();
        } else if (state is TabsliderSuccess) {
          if (state.orginalTab is UsersTab) {
            print('UsersTab');
            scrollController.addListener(() {
              if (scrollController.position.atEdge) {
                if (scrollController.position.pixels == 0) {
                  // You're at the top.
                } else {
                  // You're at the bottom.
                  _usersBloc.add(GetUsersEvent());
                  print("BOTTOM");
                }
              }
            });
          }
          if (state.orginalTab is BooksTab) {
            print('BooksTab');
            scrollController.addListener(() {
              if (scrollController.position.atEdge) {
                if (scrollController.position.pixels == 0) {
                  // You're at the top.
                } else {
                  // You're at the bottom.
                  _categoryBloc.add(GetCategoryEvent(category_id: "1"));
                  print("BOTTOM");
                }
              }
            });
          }
          _sideBarItemSelectorBloc.add(SelectItemEvent(
            currentTab: state.tab,
            context: context,
            orginalTab: state.orginalTab,
            onTap: () {
              print("XXXX");
              setState(() {});
            },
          ));
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
                usersBloc: _usersBloc,
              ),
              Row(
                children: [
                  SideBar(child: BlocBuilder<SideBarItemSelectorBloc,
                      SideBarItemSelectorState>(
                    builder: (context, state) {
                      if (state is SideBarItemSelectorInitial)
                        return Container();
                      else if (state is SideBarItemSelectorSuccess) {
                        return Column(
                          children: [
                            Visibility(
                              visible: state.add,
                              child: SideBarItem(
                                child: Image.asset(Assets.add),
                                title: "افزودن",
                                onTap: () => ShowDialog.showDialog(
                                    context, PostDialog()),
                              ),
                            ),
                            SideBarItem(
                              child: Image.asset(Assets.edit),
                              title: "ویرایش",
                              onTap: state.editFunction,
                            ),
                            SideBarItem(
                              child: Image.asset(Assets.delete),
                              title: "حذف",
                              onTap: () => ShowDialog.showDialog(
                                  context, DeleteBookDialog()),
                            ),
                            SideBarItem(
                                child: Image.asset(Assets.search),
                                title: "جستجو",
                                onTap: () {
                                  setState(() {
                                    if (visiblity == false) {
                                      padding = 57.0;
                                      visiblity = true;
                                      opacity = 1.0;
                                    } else {
                                      padding = 0.0;
                                      visiblity = false;
                                      opacity = 0.0;
                                    }
                                  });
                                }),
                          ],
                        );
                      }
                    },
                  )),
                  MainPanel(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SearchFieldSpot(
                                visiblity: visiblity,
                                opacity: opacity,
                              ),
                              AnimatedPadding(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.only(top: padding),
                                  child: BlocBuilder<TabsliderBloc,
                                      TabsliderState>(
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
                          BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                              if (state is CategoryInitial) {
                                return Container();
                              } else if (state is CategoryLazyLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is CategorySuccess) {
                                return Container();
                              } else if (state is CategoryLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is CategoryFailure) {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
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
