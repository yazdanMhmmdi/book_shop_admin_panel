import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/image_address_provider.dart';
import '../../core/utils/throttler.dart';
import '../../data/models/book_model.dart';
import '../bloc/books_bloc.dart';
import '../widgets/book_item.dart';
import '../widgets/custom_scroll_behavior.dart';
import '../widgets/dialogs/add_book_dialog.dart';
import '../widgets/dialogs/edit_book_dialog.dart';
import '../widgets/global_class.dart';
import '../widgets/main_panel.dart';
import '../widgets/nothing_found_widget.dart';
import '../widgets/pagination_loading_widget.dart';
import '../widgets/show_dialog.dart';
import '../widgets/side_bar.dart';
import '../widgets/side_bar_item.dart';

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
  List<BookModel>? booksModels;
  BooksBloc? booksBloc;
  late Map<String, String> arguments;

  @override
  void initState() {
    super.initState();
    booksBloc = BlocProvider.of<BooksBloc>(context);
    restartSearchField();
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
      // booksBloc!.add(ResetEvent());
      // booksBloc!.add(SearchEvent(
      //   categoryId: GlobalClass.currentCategoryId,
      //   search: val,
      // ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SideBar(
          children: [
            SideBarItem(
                child: Image.asset(Assets.add), title: "افزودن", onTap: () {}),
            SideBarItem(
                child: Image.asset(Assets.edit), title: "ویرایش", onTap: () {}),
            SideBarItem(
                child: Image.asset(Assets.delete), title: "حذف", onTap: () {}),
            SideBarItem(
                child: Image.asset(Assets.search),
                title: "جستجو",
                onTap: () {}),
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
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.only(top: padding),
                            child: Container()),

                        //BlocBuilder
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
}
