import 'package:book_shop_admin_panel/core/utils/image_address_provider.dart';
import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/presentation/bloc/books_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widgets/dialogs/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widgets/global_class.dart';
import 'package:book_shop_admin_panel/presentation/widgets/my_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/throttler.dart';
import '../widgets/book_item.dart';
import '../widgets/custom_scroll_behavior.dart';
import '../widgets/dialogs/delete_book_dialog.dart';
import '../widgets/dialogs/edit_book_dialog.dart';
import '../widgets/main_panel.dart';
import '../widgets/pagination_loading_widget.dart';
import '../widgets/show_dialog.dart';
import '../widgets/side_bar.dart';
import '../widgets/side_bar_item.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  Function(String) searchOnChange = (s) {};
  double opacity = 0.0;
  bool isSearch = false;
  bool visiblity = false;
  List<Widget> items = [];
  List<BookModel>? booksModels;
  BooksBloc? booksBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    booksBloc = BlocProvider.of<BooksBloc>(context);

    booksBloc!.add(FetchEvent(category: 1));
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {
        if (tabController!.indexIsChanging) {
          // _sienceTitleBloc.add(FetchBooks(tabController!.index + 1));
          print('tab changed');
        }
      });

    scrollController.addListener(() {
      //prevent from calling event twice
      Throttler throttler = Throttler(throttleGapInMillis: 200);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        throttler.run(() {
          booksBloc!.add(FetchEvent(category: 1));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BooksBloc, BooksState>(
      listener: (context, state) {
        if (state is BooksSuccess) {
          booksModels = state.booksModel;
        }
        // notify when book edited to scroll up screen
        if (state is BooksEdited) {
          scrollController.jumpTo(0);
        }
      },
      child: Scaffold(
        backgroundColor: IColors.lowBoldGreen,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              MyTabBar(tabController: tabController!),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              if (GlobalClass.pickedBookId.toString() ==
                                  book.id) {
                                ShowDialog.showDialog(
                                    context,
                                    BlocProvider.value(
                                      value:
                                          BlocProvider.of<BooksBloc>(context),
                                      child: EditBookDialog(
                                        bookModel: book,
                                      ),
                                    ));
                              }
                            });
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
                                  child: DeleteBookDialog(),
                                ));
                          }
                        }),
                  ],
                ),
                MainPanel(
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              // searchFieldSpot(
                              //     searchController, searchOnChange),
                              AnimatedPadding(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.only(top: 60),
                                  child: Container()),

                              BlocBuilder<BooksBloc, BooksState>(
                                builder: (context, state) {
                                  if (state is BooksInitial) {
                                    return Container();
                                  } else if (state is BooksLoading) {
                                    return Container();
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
                                                child:
                                                    PaginationLoadingWidget(),
                                              ),
                                            ),
                                          ]
                                        ],
                                      ),
                                    );
                                  } else if (state is BooksFailure) {
                                    return Container();
                                  } else if (state is BookNothingFound) {
                                    return Container();
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
              ]),
            ],
          ),
        ),
      ),
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
                  onPressed: () {},
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
}
