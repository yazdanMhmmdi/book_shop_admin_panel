import 'package:book_shop_admin_panel/core/utils/map_categories.dart';
import 'package:book_shop_admin_panel/presentation/widgets/category_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/image_address_provider.dart';
import '../../core/utils/throttler.dart';
import '../../data/models/book_model.dart';
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

class BooksTab extends StatefulWidget {
  const BooksTab({Key? key}) : super(key: key);

  @override
  State<BooksTab> createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  late Function(String) searchOnChange;
  double opacity = 0.0;
  double padding = 0.0;
  bool isSearch = false;
  bool visiblity = false;
  List<Widget> items = [];
  List<BookModel>? booksModels;
  BooksBloc? booksBloc;
  late Map<String, String> arguments;
  String? _categoryTypeId = categoryList[0]['category_id'];

  @override
  void initState() {
    booksBloc = BlocProvider.of<BooksBloc>(context);
    // restartSearchField();
    booksBloc!.add(ResetEvent());
    booksBloc!.add(FetchEvent(category: GlobalClass.currentCategoryId));

    scrollController.addListener(() {
      //prevent from calling event twice
      Throttler throttler = Throttler(throttleGapInMillis: 200);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        throttler.run(() {
          if (visiblity) {
            booksBloc!.add(SearchEvent(
              categoryId: GlobalClass.currentCategoryId,
              search: searchController.text,
              increasePage: true,
            ));
          } else {
            booksBloc!.add(FetchEvent(category: GlobalClass.currentCategoryId));
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
      booksBloc!.add(ResetEvent());
      booksBloc!.add(SearchEvent(
        categoryId: GlobalClass.currentCategoryId,
        search: val,
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BooksBloc, BooksState>(
      listener: (context, state) {
        if (state is BooksSuccess) {
          booksModels = state.booksModel;
        }

        //swtich/case Toasting
        switch (state.runtimeType) {
          case BooksEdited:
            ToastWidget.showSuccess(context,
                title: "ویرایش کتاب", desc: "ویرایش کتاب با موفقیت انجام شد");
            // notify when book edited to scroll up screen
            scrollController.jumpTo(0);
            break;
          case BooksAdded:
            ToastWidget.showSuccess(context,
                title: "افزودن کتاب", desc: "افزودن کتاب با موفقیت انجام شد");
            break;
          case BooksDeleted:
            ToastWidget.showSuccess(context,
                title: "حذف کتاب", desc: "حذف کتاب با موفقیت انجام شد");
            break;
          case BooksFailure:
            ToastWidget.showError(context,
                title: "خطا", desc: "خطایی رخ داده است!");
            break;
          default:
        }
      },
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SideBar(
          children: [
            SideBarItem(
                child: Image.asset(Assets.add),
                title: "افزودن",
                onTap: () {
                  ShowDialog.showDialog(
                      context,
                      BlocProvider.value(
                        value: BlocProvider.of<BooksBloc>(context),
                        child: AddBookDialog(),
                      ));
                }),
            SideBarItem(
                child: Image.asset(Assets.edit),
                title: "ویرایش",
                onTap: () {
                  if (GlobalClass.pickedBookId != 0) {
                    booksModels!.forEach((book) {
                      if (GlobalClass.pickedBookId.toString() == book.id) {
                        ShowDialog.showDialog(
                            context,
                            BlocProvider.value(
                              value: BlocProvider.of<BooksBloc>(context),
                              child: EditBookDialog(
                                bookModel: book,
                              ),
                            ));
                      }
                    });
                  } else {
                    ToastWidget.showWarning(context,
                        title: "!آیتمی برای ویرایش وجود ندارد",
                        desc: "لطفا کتابی را برای ویرایش انتخاب کنید");
                  }
                }),
            SideBarItem(
                child: Image.asset(Assets.delete),
                title: "حذف",
                onTap: () {
                  if (GlobalClass.pickedBookId != 0) {
                    ShowDialog.showDialog(
                        context,
                        BlocProvider.value(
                          value: BlocProvider.of<BooksBloc>(context),
                          child: DeleteBookDialog(
                            onSubmitTap: () {
                              if (GlobalClass.pickedBookId
                                  .toString()
                                  .isNotEmpty) {
                                BlocProvider.of<BooksBloc>(context)
                                    .add(DeleteEvent(
                                  bookId: GlobalClass.pickedBookId.toString(),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: CategoryDropdownWidget(
                              width: 180,
                              selectedValue: MapCategories.returnTitle(
                                  GlobalClass.currentCategoryId),
                              title: "",
                              optionList: categoryList,
                              selectedValueChange: (val) {
                                GlobalClass.currentCategoryId = val;
                                booksBloc!.add(ResetEvent());
                                booksBloc!.add(FetchEvent(
                                    category: GlobalClass.currentCategoryId));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    searchFieldSpot(searchController, searchOnChange),
                    Stack(
                      children: [
                        AnimatedPadding(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.only(top: padding),
                            child: Container()),
                        BlocBuilder<BooksBloc, BooksState>(
                          builder: (context, state) {
                            if (state is BooksInitial) {
                              return Container();
                            } else if (state is BooksLoading) {
                              return const LoadingWidget();
                            } else if (state is BooksSuccess) {
                              items.clear();
                              state.booksModel.forEach((element) {
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
                              return NothingFoundWidget();
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
    );
  }

  void rippleEffect(var element) {
    GlobalClass.pickedBookId = int.tryParse(element)!;
  }

  Widget returnCard(BookModel book) {
    return BooksItem(
      number: int.tryParse(book.id!)!,
      selected: (GlobalClass.pickedBookId == int.parse(book.id.toString())
          ? true
          : false),
      image: ImageAddressProvider.getAddress(book.pictureThumb!),
      title: book.name!,
      writer: book.writer!,
      rate: book.voteCount!,
      id: book.id!,
      blurhash: book.blurhash!,
      onTap: () {
        setState(() {
          //show green ripple effect animation.
          rippleEffect(book.id);
          //select book that user choosed it.
          print('selected book: ${GlobalClass.pickedBookId}');
        });
      },
      onDoubleTap: () {},
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
                    _showSearchField();
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
                            hintText: "نام کتاب را جستجو کنید...",
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

  void _showSearchField() {
    setState(() {
      if (visiblity == false) {
        booksBloc!.add(FetchEvent(
          category: GlobalClass.currentCategoryId,
        ));
        padding = 57.0;
        visiblity = true;
        opacity = 1.0;
      } else {
        booksBloc!.add(ResetEvent());

        booksBloc!.add(FetchEvent(
          category: GlobalClass.currentCategoryId,
        ));

        padding = 0.0;
        visiblity = false;
        opacity = 0.0;
      }
    });
  }

  void _getArguments() {}
}
