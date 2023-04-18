import 'package:book_shop_admin_panel/data/models/users_list_model.dart';
import 'package:book_shop_admin_panel/presentation/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widgets/dialogs/edit_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/image_address_provider.dart';
import '../../core/utils/throttler.dart';
import '../../data/models/book_model.dart';
import '../../data/models/user_model.dart';
import '../bloc/books_bloc.dart';
import '../widgets/book_item.dart';
import '../widgets/custom_scroll_behavior.dart';
import '../widgets/dialogs/add_book_dialog.dart';
import '../widgets/dialogs/delete_book_dialog.dart';
import '../widgets/dialogs/edit_book_dialog.dart';
import '../widgets/global_class.dart';
import '../widgets/loading_widget.dart';
import '../widgets/main_panel.dart';
import '../widgets/nothing_found_widget.dart';
import '../widgets/pagination_loading_widget.dart';
import '../widgets/show_dialog.dart';
import '../widgets/side_bar.dart';
import '../widgets/side_bar_item.dart';
import '../widgets/toast_widget.dart';
import '../widgets/user_item.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  TabController? tabController;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  late Function(String) searchOnChange;
  double opacity = 0.0;
  double padding = 0.0;
  bool isSearch = false;
  bool visiblity = false;
  List<Widget> items = [];
  List<UserModel>? usersList;
  UsersBloc? usersBloc;
  late Map<String, String> arguments;

  @override
  void initState() {
    super.initState();
    usersBloc = BlocProvider.of<UsersBloc>(context);
    restartSearchField();
    usersBloc!.add(GetUsersEvent());

    scrollController.addListener(() {
      //prevent from calling event twice
      Throttler throttler = Throttler(throttleGapInMillis: 200);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        throttler.run(() {
          if (visiblity) {
            usersBloc!.add(SearchUsersEvent(
              search: searchController.text,
              increasePage: true,
            ));
          } else {
            usersBloc!.add(GetUsersEvent());
          }
        });
      }
    });

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
      // _bookBloc!.add(DisposeBookEvent());
      usersBloc!.add(ResetUsersEvent());
      usersBloc!.add(SearchUsersEvent(
        search: val,
      ));
    };
    // booksBloc!.add(ResetEvent());
    // booksBloc!.add(SearchEvent(
    //   categoryId: GlobalClass.currentCategoryId,
    //   search: val,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersSuccess) {
          usersList = state.usersModel;
        }

//swtich/case Toasting
        switch (state.runtimeType) {
          case UsersEdited:
            ToastWidget.showSuccess(context,
                title: "ویرایش کاربر", desc: "ویرایش کاربر با موفقیت انجام شد");
            // notify when book edited to scroll up screen
            scrollController.jumpTo(0);
            break;
          case UsersAdded:
            ToastWidget.showSuccess(context,
                title: "افزودن کاربر", desc: "افزودن کاربر با موفقیت انجام شد");
            break;
          case UsersDeleted:
            ToastWidget.showSuccess(context,
                title: "حذف کاربر", desc: "حذف کاربر با موفقیت انجام شد");
            break;
          case UsersFailure:
            ToastWidget.showError(context,
                title: "خطا", desc: "خطایی رخ داده است!");
            break;
          default:
        }
      },
      child: Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SideBar(
            children: [
              SideBarItem(
                  child: Image.asset(Assets.edit),
                  title: "ویرایش",
                  onTap: () {
                    if (GlobalClass.pickedUserId != 0) {
                      usersList!.forEach((user) {
                        if (GlobalClass.pickedUserId.toString() == user.id) {
                          ShowDialog.showDialog(
                              context,
                              BlocProvider.value(
                                value: BlocProvider.of<UsersBloc>(context),
                                child: EditUserDialog(
                                  userModel: user,
                                ),
                              ));
                        }
                      });
                    } else {
                      ToastWidget.showWarning(context,
                          title: "!آیتمی برای ویرایش وجود ندارد",
                          desc: "لطفا کاربری را برای ویرایش انتخاب کنید");
                    }
                  }),
              SideBarItem(
                  child: Image.asset(Assets.delete),
                  title: "حذف",
                  onTap: () {
                    if (GlobalClass.pickedUserId != 0) {
                      ShowDialog.showDialog(
                          context,
                          BlocProvider.value(
                            value: BlocProvider.of<UsersBloc>(context),
                            child: DeleteBookDialog(
                              onSubmitTap: () {
                                if (GlobalClass.pickedUserId
                                    .toString()
                                    .isNotEmpty) {
                                  BlocProvider.of<UsersBloc>(context)
                                      .add(DeleteUsersEvent(
                                    userId: GlobalClass.pickedUserId.toString(),
                                  ));
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ));
                    } else {
                      ToastWidget.showWarning(context,
                          title: "!آیتمی برای حذف کردن وجود ندارد",
                          desc: "لطفا کتابی را برای حذف کردن انتخاب کنید");
                    }
                  }),
              SideBarItem(
                  child: Image.asset(Assets.search),
                  title: "جستجو",
                  onTap: () {
                    _showSearchField();
                  }),
            ],
          ),
          MainPanel(
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      searchFieldSpot(searchController, searchOnChange),
                      Stack(
                        children: [
                          AnimatedPadding(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.only(top: padding),
                              child: Container()),
                          BlocBuilder<UsersBloc, UsersState>(
                            builder: (context, state) {
                              if (state is UsersInitial) {
                                return Container();
                              } else if (state is UsersLoading) {
                                return const LoadingWidget();
                              } else if (state is UsersSuccess) {
                                items.clear();
                                state.usersModel.forEach((element) {
                                  items.add(returnCard(element));
                                });
                                return Padding(
                                  padding: const EdgeInsets.all(26.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      Wrap(
                                        children: items,
                                      ),
                                      if (state.noMoreData) ...[
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16),
                                            child: PaginationLoadingWidget(),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                );
                              } else if (state is BooksFailure) {
                                return Container();
                              } else if (state is BookNothingFound) {
                                return const NothingFoundWidget();
                              } else {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void rippleEffect(var element) {
    GlobalClass.pickedBookId = int.tryParse(element)!;
  }

  Widget returnCard(UserModel user) {
    return UserItem(
      id: "${user.id}",
      name: "${user.username}",
      username: "${user.password}",
      number: int.parse(user.id!),
      onTap: () async {
        setState(() {
          GlobalClass.pickedUserId = int.parse(user.id.toString());
        });
        // usersBloc!.add(SelectUsersEvent(user_id: user.id!));
      },
    );
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
                    restartSearchField();
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
                            hintText: "نام کاربر را جستجو کنید...",
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

  void _showSearchField() {
    setState(() {
      if (visiblity == false) {
        usersBloc!.add(GetUsersEvent());
        padding = 57.0;
        visiblity = true;
        opacity = 1.0;
      } else {
        usersBloc!.add(ResetUsersEvent());

        usersBloc!.add(GetUsersEvent());

        padding = 0.0;
        visiblity = false;
        opacity = 0.0;
      }
    });
  }

  void restartSearchField() {
    setState(() {
      searchController.text = "";
      isSearch = false;
    });
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
    // booksBloc!.add(SearchEvent(
    //     categoryId: GlobalClass.currentCategoryId,
    //     search: searchController.text));
  }
}
