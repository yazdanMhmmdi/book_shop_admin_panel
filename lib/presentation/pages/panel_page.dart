import '../../data/models/book_model.dart';
import '../bloc/books_bloc.dart';
import '../bloc/users_bloc.dart';
import '../tabs/books_tab.dart';
import '../tabs/users_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../widgets/circular_indicator.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({Key? key}) : super(key: key);

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
  UsersBloc? usersBloc;

  @override
  void initState() {
    initPage();
    initListeners();

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
                controller: tabController,
                children: const [
                  BooksTab(),
                  UsersTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  initPage() {
    booksBloc = BlocProvider.of<BooksBloc>(context);
    usersBloc = BlocProvider.of<UsersBloc>(context);
  }

  initListeners() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {});
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
      controller: tabController,
      tabs: const [
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
