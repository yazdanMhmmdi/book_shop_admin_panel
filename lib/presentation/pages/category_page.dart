import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/throttler.dart';
import '../../data/models/book_model.dart';
import '../widgets/category_item.dart';
import '../widgets/custom_scroll_behavior.dart';
import '../widgets/global_class.dart';
import '../widgets/main_panel.dart';
import '../widgets/my_tab_bar.dart';

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

  @override
  void initState() {
    super.initState();
    initPage();
    initListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lowBoldGreen,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MyTabBar(tabController: tabController!),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainPanel(
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.categorySubject,
                                style: TextStyle(
                                    color: IColors.black85,
                                    fontSize: 20,
                                    fontFamily: Strings.fontIranSans,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 26),
                              Wrap(
                                children: [
                                  CategoryItem(
                                      title: categoryList[0]['title']!,
                                      onTap: () {
                                        GlobalClass.currentCategoryId =
                                            categoryList[0]['category_id']!;
                                        Navigator.pushNamed(
                                          context,
                                          '/panelpage',
                                        );
                                      },
                                      child: Image.asset(
                                          categoryList[0]['image']!)),
                                  CategoryItem(
                                    title: categoryList[1]['title']!,
                                    onTap: () {
                                      GlobalClass.currentCategoryId =
                                          categoryList[1]['category_id']!;
                                      Navigator.pushNamed(
                                        context,
                                        '/panelpage',
                                      );
                                    },
                                    child:
                                        Image.asset(categoryList[1]['image']!),
                                  ),
                                  CategoryItem(
                                    title: categoryList[2]['title']!,
                                    onTap: () {
                                      GlobalClass.currentCategoryId =
                                          categoryList[2]['category_id']!;
                                      Navigator.pushNamed(
                                        context,
                                        '/panelpage',
                                      );
                                    },
                                    child:
                                        Image.asset(categoryList[2]['image']!),
                                  ),
                                  CategoryItem(
                                    title: categoryList[3]['title']!,
                                    onTap: () {
                                      GlobalClass.currentCategoryId =
                                          categoryList[2]['category_id']!;
                                      Navigator.pushNamed(
                                        context,
                                        '/panelpage',
                                      );
                                    },
                                    child:
                                        Image.asset(categoryList[3]['image']!),
                                  ),
                                  CategoryItem(
                                    title: categoryList[4]['title']!,
                                    onTap: () {
                                      GlobalClass.currentCategoryId =
                                          categoryList[4]['category_id']!;
                                      Navigator.pushNamed(
                                        context,
                                        '/panelpage',
                                      );
                                    },
                                    child:
                                        Image.asset(categoryList[4]['image']!),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  initPage() {

    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  initListeners() {
    scrollController.addListener(() {
      Throttler throttler = Throttler(throttleGapInMillis: 200);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        throttler.run(() {});
      }
    });
  }

  void rippleEffect(var element) {
    GlobalClass.pickedBookId = int.tryParse(element)!;
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
                          style: const TextStyle(
                              fontFamily: Strings.fontIranSans, fontSize: 16),
                          decoration: const InputDecoration(
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
