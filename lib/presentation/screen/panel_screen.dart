import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<TitleSelectorState> cartKey = GlobalKey();

class PanelScreen extends StatefulWidget {
  TabsliderBloc tabsliderBloc;
  static int status;
  PanelScreen({@required this.tabsliderBloc});
  @override
  _PanelScreenState createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  int tab;
  ScrollController scrollController;
  TextEditingController searchController = new TextEditingController();

  SideBarItemSelectorBloc _sideBarItemSelectorBloc;
  BookBloc _bookBloc;
  UsersBloc _usersBloc;
  String tabStatus = "category";
  bool visiblity = false;
  double padding = 0.0;
  double opacity = 0.0;
  bool isSearch = false;
  @override
  void initState() {
    _sideBarItemSelectorBloc =
        BlocProvider.of<SideBarItemSelectorBloc>(context);
    _bookBloc = BlocProvider.of<BookBloc>(context);
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
            tabStatus = "users";

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
            setState(() {
              tabStatus = "books";
            });
            scrollController.addListener(() {
              if (scrollController.position.atEdge) {
                if (scrollController.position.pixels == 0) {
                  // You're at the top.
                } else {
                  // You're at the bottom.
                  if (isSearch) {
                    _bookBloc.add(SearchBookEvent(isLazyLoad: true));
                  } else {
                    _bookBloc.add(GetBookEvent(category_id: "1"));
                    print("BOTTOM");
                  }
                }
              }
            });
          }
          _sideBarItemSelectorBloc.add(SelectItemEvent(
            currentTab: state.tab,
            context: context,
            orginalTab: state.orginalTab,
            bookBloc: _bookBloc,
            usersBloc: _usersBloc,
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
                                    context,
                                    BlocProvider.value(
                                        value:
                                            BlocProvider.of<BookBloc>(context),
                                        child: AddBookDialog())),
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
                                  context,
                                  MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(value: _bookBloc),
                                        BlocProvider.value(
                                            value: widget.tabsliderBloc)
                                      ],
                                      child: DeleteBookDialog(
                                        tabStatus: tabStatus,
                                        status: getStatus(),
                                      ))),
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
                              searchFieldSpot(searchController),
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
                          BlocBuilder<BookBloc, BookState>(
                            builder: (context, state) {
                              if (state is BookInitial) {
                                return Container();
                              } else if (state is BookLazyLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is BookSearchLazyLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is BookSuccess) {
                                isSearch = state.isSearch;
                                return Container();
                              } else if (state is BookLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is BookFailure) {
                                return Container();
                              } else {
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

  Widget searchFieldSpot(TextEditingController controller) {
    bool iconStatus; //true : X, false: search

    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: opacity,
      child: Visibility(
        visible: visiblity,
        child: Padding(
          padding: const EdgeInsets.only(top: 22, left: 22, right: 22),
          child: Container(
            height: 43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                IconButton(
                  icon: Icon(isSearch == true ? Icons.close : Icons.search),
                  color: IColors.boldGreen,
                  onPressed: () {
                    _bookBloc.add(DisposeBookEvent());
                    _bookBloc.add(GetBookEvent(category_id: "1"));

                    setState(() {
                      controller.text = "";
                      controller.clear();
                      controller.value = TextEditingValue(text: "");
                      isSearch = false;
                    });
                  },
                ),
                Container(
                  height: 43,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          maxLines: 3,
                          onChanged: (val) {
                            if (val != "") {
                              setState(() {
                                isSearch = true;
                              });
                            } else {
                              setState(() {
                                isSearch = false;
                              });
                            }
                            _bookBloc.add(DisposeBookEvent());
                            _bookBloc.add(SearchBookEvent(
                                category_id: "1",
                                search: val,
                                isLazyLoad: false));
                          },
                          controller: controller,
                          style:
                              TextStyle(fontFamily: 'IranSans', fontSize: 16),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "نام کتاب را جستجو کنید...",
                            hintStyle:
                                TextStyle(fontFamily: 'IranSans', fontSize: 16),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              top: 11,
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getStatus() {
    return PanelScreen.status.toString();
  }
}
