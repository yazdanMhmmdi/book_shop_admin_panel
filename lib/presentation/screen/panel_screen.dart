import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/chat_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/chatlist_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/side_bar_item_selector_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/logic/cubit/internet_cubit.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/category_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/chat_list_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/chat_tab.dart';
import 'package:book_shop_admin_panel/presentation/tab/users_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/action_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/custom_tab_slider.dart';
import 'package:book_shop_admin_panel/presentation/widget/delete_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_user_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/main_panel.dart';
import 'package:book_shop_admin_panel/presentation/widget/no_network_flare.dart';
import 'package:book_shop_admin_panel/presentation/widget/post_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/search_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/show_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/side_bar_item.dart';
import 'package:book_shop_admin_panel/presentation/widget/title_selector.dart';
import 'package:book_shop_admin_panel/presentation/widget/toast_widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

GlobalKey<TitleSelectorState> cartKey = GlobalKey();

class PanelScreen extends StatefulWidget {
  TabsliderBloc tabsliderBloc;
  static int status;
  static ScrollController scrollController;
  static TextEditingController messageController = new TextEditingController();
  PanelScreen({@required this.tabsliderBloc});
  @override
  _PanelScreenState createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  int tab;
  TextEditingController searchController = new TextEditingController();

  SideBarItemSelectorBloc _sideBarItemSelectorBloc;
  BookBloc _bookBloc;
  ChatlistBloc _chatlistBloc;
  UsersBloc _usersBloc;
  ChatBloc _chatBloc;
  String tabStatus = "category";
  bool visiblity = false;
  double padding = 0.0;
  double opacity = 0.0;
  bool isSearch = false;
  String hintText = "";
  Function(String) searchOnChange;
  bool bookSelected;
  bool isAnyBookSelected = false;
  String selectedBookId = "0";
  bool isAnyUserSelected = false;
  String selectedUserId = "0";
  Color backgroundColor = IColors.lowBoldGreen;
  bool progress = false;
  @override
  void initState() {
    _sideBarItemSelectorBloc =
        BlocProvider.of<SideBarItemSelectorBloc>(context);
    _bookBloc = BlocProvider.of<BookBloc>(context);
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    _chatlistBloc = BlocProvider.of<ChatlistBloc>(context);
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    PanelScreen.scrollController = new ScrollController();
    _chatBloc.add(SocketInitial());

    super.initState();
  }

  void restartSearchField() {
    if (visiblity == true) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: MultiBlocListener(
            listeners: [
              BlocListener<TabsliderBloc, TabsliderState>(
                  listener: (context, state) {
                if (state is TabsliderInitial) {
                  return Container();
                } else if (state is TabsliderSuccess) {
                  if (state.orginalTab is UsersTab) {
                    print('UsersTab');
                    setState(() {
                      tabStatus = "users";
                    });
                    restartSearchField();
                    PanelScreen.scrollController.addListener(() {
                      if (PanelScreen.scrollController.position.atEdge) {
                        if (PanelScreen.scrollController.position.pixels == 0) {
                          // You're at the top.
                        } else {
                          // You're at the bottom.
                          if (isSearch) {
                            _usersBloc.add(SearchUsersEvent(isLazyLoad: true));
                          } else {
                            _usersBloc.add(GetUsersEvent());

                            print("BOTTOM");
                          }
                          print("BOTTOM");
                        }
                      }
                    });
                  }
                  if (state.orginalTab is BooksTab) {
                    print('BooksTab');

                    restartSearchField();
                    setState(() {
                      tabStatus = "books";
                    });
                    PanelScreen.scrollController.addListener(() {
                      if (PanelScreen.scrollController.position.atEdge) {
                        if (PanelScreen.scrollController.position.pixels == 0) {
                          // You're at the top.
                        } else {
                          // You're at the bottom.
                          if (isSearch) {
                            _bookBloc.add(SearchBookEvent(isLazyLoad: true));
                          } else {
                            _bookBloc.add(GetBookEvent());
                            print("BOTTOM");
                          }
                        }
                      }
                    });
                  }
                  if (state.orginalTab is CategoryTab) {
                    restartSearchField();
                  }
                  if (state.orginalTab is ChatListTab) {
                    restartSearchField();
                    setState(() {
                      tabStatus = "chatlist";
                    });
                    PanelScreen.scrollController.addListener(() {
                      if (PanelScreen.scrollController.position.atEdge) {
                        if (PanelScreen.scrollController.position.pixels == 0) {
                          // You're at the top.
                        } else {
                          // You're at the bottom.
                          if (isSearch) {
                            // _bookBloc.add(SearchBookEvent(isLazyLoad: true));
                          } else {
                            _chatlistBloc.add(GetChatlist());
                            print("BOTTOM");
                          }
                        }
                      }
                    });
                  }
                  if (state.orginalTab is ChatTab) {
                    setState(() {
                      tabStatus = "chat";
                    });
                    _chatlistBloc.add(GetChatlist());
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
              }),
              BlocListener<BookBloc, BookState>(listener: (context, state) {
                if (state is GetSelectedItem) {
                  setState(() {
                    isAnyBookSelected = true;
                  });
                } else if (state is BookSuccess) {
                  setState(() {
                    selectedBookId = state.selectedBookId;
                    print("selected: ${selectedBookId}");
                  });
                }
              }),
              BlocListener<UsersBloc, UsersState>(listener: (context, state) {
                if (state is GetSelectedUser) {
                  setState(() {
                    isAnyUserSelected = true;
                  });
                } else if (state is UsersSuccess) {
                  setState(() {
                    selectedUserId = state.selectedUserId;
                    print("selected: ${selectedBookId}");
                  });
                }
              })
            ],
            child: BlocConsumer<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is InternetConnected) {
                  setState(() {
                    backgroundColor = IColors.lowBoldGreen;
                  });
                } else {
                  setState(() {
                    backgroundColor = Colors.white;
                  });
                }
              },
              builder: (context, state) {
                if (state is InternetConnected) {
                  backgroundColor = IColors.lowBoldGreen;
                  return internetConnectedUi();
                } else {
                  backgroundColor = Colors.white;
                  return internetDisconnectedUI();
                }
              },
            )),
      ),
    );
  }

  Widget internetConnectedUi() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Column(
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
                                title: "????????????",
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
                                title: "????????????",
                                onTap: state.editFunction),
                            SideBarItem(
                                child: Image.asset(Assets.delete),
                                title: "??????",
                                onTap: () {
                                  if (selectedBookId != "0" &&
                                      tabStatus == "books") {
                                    ShowDialog.showDialog(
                                        context,
                                        MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                  value: _bookBloc),
                                              BlocProvider.value(
                                                  value: widget.tabsliderBloc),
                                              BlocProvider.value(
                                                  value: _usersBloc),
                                            ],
                                            child: DeleteBookDialog(
                                              tabStatus: tabStatus,
                                              status: getStatus(),
                                            )));
                                  } else if (selectedUserId != "0" &&
                                      tabStatus == "users") {
                                    ShowDialog.showDialog(
                                        context,
                                        MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                  value: _bookBloc),
                                              BlocProvider.value(
                                                  value: widget.tabsliderBloc),
                                              BlocProvider.value(
                                                  value: _usersBloc),
                                            ],
                                            child: DeleteBookDialog(
                                              tabStatus: tabStatus,
                                              status: getStatus(),
                                            )));
                                  } else
                                    showToastWidget(ToastWidget(),
                                        context: context,
                                        position: ToastPosition.bottom);
                                }),
                            SideBarItem(
                                child: Image.asset(Assets.search),
                                title: "??????????",
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
                                  if (tabStatus == "books") {
                                    setState(() {
                                      searchOnChange = (val) {
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
                                      };
                                      hintText =
                                          "?????? ???????? ???????? ?????? ???? ?????????? ????????...";
                                    });
                                  } else if (tabStatus == "users") {
                                    setState(() {
                                      searchOnChange = (val) {
                                        if (val != "") {
                                          setState(() {
                                            isSearch = true;
                                          });
                                        } else {
                                          setState(() {
                                            isSearch = false;
                                          });
                                        }
                                        _usersBloc.add(DisposeUsersEvent());
                                        _usersBloc.add(SearchUsersEvent(
                                            search: val, isLazyLoad: false));
                                      };
                                    });
                                    hintText =
                                        "?????? ?????????? ???????? ?????? ?????? ???? ?????????? ????????...";
                                  }
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
                      controller: PanelScreen.scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              searchFieldSpot(searchController, searchOnChange),
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
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else if (state is BookFailure) {
                                return Container();
                              } else {
                                return Container();
                              }
                            },
                          ),

                          // BlocBuilder<ChatlistBloc, ChatlistState>(
                          //   builder: (context, state) {
                          //     if (state is ChatlistInitial) {
                          //       return Container();
                          //     } else if (state is ChatlistLoading) {
                          //       return Center(child: CircularProgressIndicator());
                          //     } else if (state is ChatlistSuccess) {
                          //       return Container();
                          //     } else if (state is ChatlistFailure) {
                          //       return Container();
                          //     } else if (state is ChatlistEmpty) {
                          //       return Container();
                          //     }
                          //   },
                          // )

                          // BlocBuilder<ChatlistBloc, ChatlistState>(
                          //     builder: (context, state) {
                          //   if (state is ChatlistInitial) {
                          //     return Container(
                          //       child: Center(child: CircularProgressIndicator()),
                          //     );
                          //   } else if (state is ChatlistLoading) {
                          //     return Container(
                          //       child: Center(child: CircularProgressIndicator()),
                          //     );
                          //   } else if (state is ChatlistFailure) {
                          //     return Container();
                          //   } else if (state is ChatlistEmpty) {
                          //     return Container();
                          //   }
                          // }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          tabStatus == "chat"
              ? Positioned(
                  bottom: 6,
                  right: 85,
                  left: 8,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: IColors.lowBoldGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print(PanelScreen.messageController.text);
                                    _chatBloc.add(SendSocketMessage(
                                        message: PanelScreen
                                            .messageController.text));
                                    PanelScreen.messageController.text = "";
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: IColors.boldGreen,
                                    size: 22,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: PanelScreen.messageController,
                                    style: TextStyle(
                                      color: IColors.black85,
                                      fontFamily: Strings.fontIranSans,
                                      fontSize: 14,
                                    ),
                                    minLines: 1,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "sdsasdas",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget internetDisconnectedUI() {
    return NoNetworkFlare();
  }

  Widget searchFieldSpot(
      TextEditingController controller, Function(String) function) {
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
                    if (tabStatus == "books") {
                      _bookBloc.add(DisposeBookEvent());
                      _bookBloc.add(GetBookEvent());
                    } else if (tabStatus == "users") {
                      _usersBloc.add(DisposeUsersEvent());
                      _usersBloc.add(GetUsersEvent());
                    }
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
                          onChanged: function,
                          controller: controller,
                          style: TextStyle(
                              fontFamily: Strings.fontIranSans, fontSize: 16),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hintText,
                            hintStyle: TextStyle(
                                fontFamily: Strings.fontIranSans, fontSize: 16),
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
