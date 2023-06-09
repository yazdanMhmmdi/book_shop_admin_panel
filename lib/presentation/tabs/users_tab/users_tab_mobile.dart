// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/throttler.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/users_bloc.dart';
import '../../cubit/user_validation_cubit.dart';
import '../../widgets/custom_scroll_behavior.dart';
import '../../widgets/dialogs/edit_user_dialog_mobile.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/nothing_found_widget.dart';
import '../../widgets/pagination_loading_widget.dart';
import '../../widgets/show_dialog.dart';
import '../../widgets/toast_widget.dart';
import '../../widgets/user_item/user_item_mobile.dart';

class UsersTabMobile extends StatefulWidget {
  int itemIndex = 1;

  UsersTabMobile({Key? key}) : super(key: key);
  @override
  State<UsersTabMobile> createState() => _UsersTabMobileState();
}

class _UsersTabMobileState extends State<UsersTabMobile> {
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

  @override
  void initState() {
    super.initState();
    initTab();
    initListeners();
    usersBloc!.add(ResetUsersEvent());
    usersBloc!.add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersSuccess) {
          usersList = state.usersModel;
        }

        switchCaseToasting(state);
      },
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          child: Column(
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
                        for (var element in state.usersModel) {
                          items.add(returnCard(element));
                        }
                        return Padding(
                          padding: const EdgeInsets.all(26.0),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: items,
                              ),
                              if (state.noMoreData) ...[
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: PaginationLoadingWidget(),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        );
                      } else if (state is UsersFailure) {
                        return Container();
                      } else if (state is UserNothingFound) {
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
    );
  }

  initListeners() {
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
  }

  switchCaseToasting(UsersState state) {
    //swtich/case Toasting
    switch (state.runtimeType) {
      case UsersEdited:
        ToastWidget.showSuccess(context,
            title: Strings.userTabWarningEditBooks,
            desc: Strings.userTabWarningEditBooksDesc);
        // notify when book edited to scroll up screen
        scrollController.jumpTo(0);
        break;
      case UsersDeleted:
        ToastWidget.showSuccess(context,
            title: Strings.userTabWarningDeleteBook,
            desc: Strings.userTabWarningDeleteBookDesc);
        break;
      case UsersFailure:
        ToastWidget.showError(context,
            title: Strings.userTabWarningError, desc: "خطایی رخ داده است!");
        break;
      default:
    }
  }

  Widget searchFieldSpot(
      TextEditingController controller, Function(String) function) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
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
                const SizedBox(
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
                          style: const TextStyle(
                              fontFamily: Strings.fontIranSans, fontSize: 16),
                          decoration: const InputDecoration(
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

  Widget returnCard(UserModel user) {
    return UserItemMobile(
      userModel: user,
      onDelete: (context) {
        usersBloc!.add(DeleteUsersEvent(userId: user.id));
        usersBloc!.add(ResetUsersEvent());
        usersBloc!.add(GetUsersEvent());

        // usersBloc!.add(SelectUsersEvent(user_id: user.id!));
      },
      onEdit: (context) {
        ShowDialog.showDialog(
            context,
            MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<UsersBloc>(context),
                ),
                BlocProvider(
                  create: (context) => UserValidationCubit(),
                ),
              ],
              child: EditUserDialogMobile(
                userModel: user,
              ),
            ));
      },
    );
  }

  initTab() {
    widget.itemIndex = 0;
    usersBloc = BlocProvider.of<UsersBloc>(context);
  }

  @override
  void dispose() {
    widget.itemIndex = 0;
    super.dispose();
  }
}
