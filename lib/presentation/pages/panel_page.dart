import 'package:book_shop_admin_panel/core/utils/image_address_provider.dart';
import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/presentation/bloc/books_bloc.dart';
import 'package:book_shop_admin_panel/presentation/tabs/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/tabs/users_tab.dart';
import 'package:book_shop_admin_panel/presentation/widgets/dialogs/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widgets/global_class.dart';
import 'package:book_shop_admin_panel/presentation/widgets/my_tab_bar.dart';
import 'package:book_shop_admin_panel/presentation/widgets/nothing_found_widget.dart';
import 'package:book_shop_admin_panel/presentation/widgets/toast_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/throttler.dart';
import '../widgets/book_item.dart';
import '../widgets/circular_indicator.dart';
import '../widgets/custom_scroll_behavior.dart';
import '../widgets/dialogs/delete_book_dialog.dart';
import '../widgets/dialogs/edit_book_dialog.dart';
import '../widgets/main_panel.dart';
import '../widgets/pagination_loading_widget.dart';
import '../widgets/show_dialog.dart';
import '../widgets/side_bar.dart';
import '../widgets/side_bar_item.dart';

class PanelPage extends StatefulWidget {
  PanelPage({Key? key}) : super(key: key);

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage>
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

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {
        if (tabController!.indexIsChanging) {
          print('tab changed');
        }
      });
    super.initState();
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
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0, right: 64),
              child: Container(
                height: 64,
                width: MediaQuery.of(context).size.width,
                color: IColors.lowBoldGreen,
                child: _tabBar(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BooksTab(),
                  UsersTab(),
                ],
                controller: tabController,
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
      indicator: CircularIndicator(color: Colors.black87, radius: 4),
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
      controller: tabController,
      tabs: [
        Tab(
          text: Strings.tabBooks,
        ),
        Tab(
          text: Strings.tabUsers,
        ),
      ],
    );
  }
}
