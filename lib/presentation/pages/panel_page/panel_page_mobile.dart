import '../../../core/constants/i_colors.dart';
import '../../tabs/book_tab/books_tab_mobile.dart';
import '../../tabs/settings_tab/settings_tab_mobile.dart';
import '../../tabs/users_tab/users_tab_mobile.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../widgets/circular_indicator.dart';

class PanelPageMobile extends StatefulWidget {
  const PanelPageMobile({Key? key}) : super(key: key);

  @override
  State<PanelPageMobile> createState() => _PanelPageMobileState();
}

class _PanelPageMobileState extends State<PanelPageMobile>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int fabIndex = 0;
  final List<FloatingActionButton> fab = [
    FloatingActionButton(
      child: const Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: () {},
    ),
    FloatingActionButton(
      onPressed: () {
        print("2");
      },
    ),
  ];
  @override
  void initState() {
    initListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                bottom: _tabBar(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  const BooksTabMobile(),
                  UsersTabMobile(),
                   SettingsTabMobile(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      labelColor: IColors.black85,
      indicator: CircularIndicator(
        color: Colors.black87,
        radius: 4,
      ),
      labelStyle: const TextStyle(
        fontSize: 22,
        fontFamily: "IranSans",
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontFamily: "IranSans",
        fontWeight: FontWeight.w700,
      ),
      labelPadding: const EdgeInsets.fromLTRB(55, 0, 55, 0),
      controller: tabController,
      tabs: const [
        Tab(
          text: Strings.tabBooks,
        ),
        Tab(
          text: Strings.tabUsers,
        ),
        Tab(
          text: Strings.tabSettings,
        ),
      ],
    );
  }

  initListeners() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          fabIndex = tabController!.index;
        });
      });
  }
}
