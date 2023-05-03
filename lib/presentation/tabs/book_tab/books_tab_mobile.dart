import 'dart:async';

import 'package:book_shop_admin_panel/presentation/widgets/book_item/book_item_mobile.dart';
import 'package:book_shop_admin_panel/presentation/widgets/category_drowp_down_widget/category_drop_down_widget_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/image_address_provider.dart';
import '../../../core/utils/map_categories.dart';
import '../../../core/utils/throttler.dart';
import '../../../data/models/book_model.dart';
import '../../bloc/books_bloc.dart';
import '../../widgets/category_drowp_down_widget/category_dropdown_widget_desktop.dart';
import '../../widgets/custom_scroll_behavior.dart';
import '../../widgets/global_class.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/nothing_found_widget.dart';
import '../../widgets/pagination_loading_widget.dart';
import '../../widgets/toast_widget.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

class BooksTabMobile extends StatefulWidget {
  const BooksTabMobile({Key? key}) : super(key: key);

  @override
  State<BooksTabMobile> createState() => _BooksTabMobileState();
}

class _BooksTabMobileState extends State<BooksTabMobile> {
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

  /// when you want to close the menu you have to create
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey =
      GlobalKey<AnimatedFloatingActionButtonState>();

  /// and then assign it to the our widget library
  @override
  void initState() {
    super.initState();
    initTab();
    initListeners();
    //prevent from junk
    Timer(const Duration(milliseconds: kAnimationDuration), () {
      booksBloc!.add(ResetEvent());
      booksBloc!.add(FetchEvent(category: GlobalClass.currentCategoryId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) {
          if (state is BooksSuccess) {
            booksModels = state.booksModel;
          }

          switchCaseToasting(state);
        },
        child: SafeArea(
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: CategoryDropdownWidgetMobile(
                        width: 160,
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
                  searchFieldSpot(searchController, searchOnChange),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      AnimatedPadding(
                          duration: const Duration(milliseconds: 300),
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
                            for (var element in state.booksModel) {
                              items.add(returnCard(element));
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 26),
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
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
                            return const Center(child: NothingFoundWidget());
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
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[
            Container(
              child: FloatingActionButton(
                onPressed: () {
                  _showSearchField();
                },
                heroTag: 'search',
                tooltip: 'جستجو',
                backgroundColor: IColors.boldGreen,
                child: const Icon(Icons.search),
              ),
            ),
            Container(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editPage');
                },
                heroTag: 'addBooks',
                tooltip: 'افزودن کتاب',
                backgroundColor: IColors.boldGreen,
                child: const Icon(Icons.add),
              ),
            )
          ],
          key: fabKey,
          tooltip: "ابزار ها",
          colorStartAnimation: IColors.boldGreen,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
    );
  }

  Widget returnCard(BookModel book) {
    return BookItemMobile(
      bookModel: book,
      onTap: (context) {
        booksBloc!.add(DeleteEvent(bookId: book.id));
        booksBloc!.add(ResetEvent());
        booksBloc!.add(FetchEvent(category: GlobalClass.currentCategoryId));
      },
    );
  }

  void rippleEffect(var element) {
    GlobalClass.pickedBookId = int.tryParse(element)!;
  }

  initListeners() {
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

  switchCaseToasting(BooksState state) {
    //swtich/case Toasting
    switch (state.runtimeType) {
      case BooksEdited:
        ToastWidget.showSuccess(context,
            title: Strings.bookTabWarningEditBooks,
            desc: Strings.bookTabWarningEditBooksDesc);
        // notify when book edited to scroll up screen

        scrollController.animateTo(0,
            duration: const Duration(milliseconds: kAnimationDuration),
            curve: Curves.easeIn);
        break;
      case BooksAdded:
        ToastWidget.showSuccess(context,
            title: Strings.bookTabWarningAddBooks,
            desc: Strings.bookTabWarningAddBooksDesc);
        break;
      case BooksDeleted:
        ToastWidget.showSuccess(context,
            title: Strings.bookTabWarningDeleteBook,
            desc: Strings.bookTabWarningDeleteBookDesc);
        break;
      case BooksFailure:
        ToastWidget.showError(context,
            title: Strings.bookTabWarningError, desc: "");
        break;
      default:
    }
  }

  initTab() {
    booksBloc = BlocProvider.of<BooksBloc>(context);
  }

  Widget searchFieldSpot(
      TextEditingController controller, Function(String) function) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: kAnimationDuration),
      opacity: opacity,
      child: Visibility(
        visible: visiblity,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 22, right: 22),
          child: Container(
            height: 38,
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
                    _showSearchField();
                  },
                ),
                Container(
                  height: 38,
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
                              fontFamily: Strings.fontIranSans, fontSize: 14),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: Strings.bookTabSearchHint,
                            hintStyle: TextStyle(
                                fontFamily: Strings.fontIranSans, fontSize: 14),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              top: 10,
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
        isSearch = false;
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
}
