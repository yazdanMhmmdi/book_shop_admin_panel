import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/data/model/book_model.dart';
import 'package:book_shop_admin_panel/data/repository/book_repository.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widget/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTab extends StatefulWidget {
  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  TabsliderBloc _tabsliderBloc;
  BookBloc _bookBloc;
  @override
  void initState() {
    _tabsliderBloc = BlocProvider.of<TabsliderBloc>(context);
    _bookBloc = BlocProvider.of<BookBloc>(context);

    _tabsliderBloc.add(MoveForwardEvent(
        tab: 0, tabSliderBloc: _tabsliderBloc, bookBloc: _bookBloc));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "موضوعات",
                style: TextStyle(
                    color: IColors.black85,
                    fontSize: 20,
                    fontFamily: "IranSans",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 26),
              Wrap(
                children: [
                  CategoryItem(
                      child: Image.asset(Assets.labTool),
                      title: "علمی",
                      onTap: () {
                        _bookBloc
                            .add(AddCategoryEvent(currentTabCategory: "1"));
                        _tabsliderBloc.add(MoveForwardEvent(
                            tab: 2,
                            tabSliderBloc: _tabsliderBloc,
                            bookBloc: _bookBloc));
                        _bookBloc.add(DisposeBookEvent());
                        _bookBloc.add(GetBookEvent());
                      }),
                  CategoryItem(
                    child: Image.asset(Assets.medicine),
                    title: "دارویی",
                    onTap: () {
                      _bookBloc.add(AddCategoryEvent(currentTabCategory: "2"));
                      _tabsliderBloc.add(MoveForwardEvent(
                          tab: 2,
                          tabSliderBloc: _tabsliderBloc,
                          bookBloc: _bookBloc));
                      _bookBloc.add(DisposeBookEvent());
                      _bookBloc.add(GetBookEvent());
                    },
                  ),
                  CategoryItem(
                    child: Image.asset(Assets.hourglass),
                    title: "تاریخی",
                    onTap: () {
                      _bookBloc.add(AddCategoryEvent(currentTabCategory: "3"));
                      _tabsliderBloc.add(MoveForwardEvent(
                          tab: 2,
                          tabSliderBloc: _tabsliderBloc,
                          bookBloc: _bookBloc));
                      _bookBloc.add(DisposeBookEvent());
                      _bookBloc.add(GetBookEvent());
                    },
                  ),
                  CategoryItem(
                    child: Image.asset(Assets.auction),
                    title: "قضایی",
                    onTap: () {
                      _bookBloc.add(AddCategoryEvent(currentTabCategory: "4"));
                      _tabsliderBloc.add(MoveForwardEvent(
                          tab: 2,
                          tabSliderBloc: _tabsliderBloc,
                          bookBloc: _bookBloc));
                      _bookBloc.add(DisposeBookEvent());
                      _bookBloc.add(GetBookEvent());
                    },
                  ),
                  CategoryItem(
                    child: Image.asset(Assets.dish),
                    title: "غذایی",
                    onTap: () {
                      _bookBloc.add(AddCategoryEvent(currentTabCategory: "5"));
                      _tabsliderBloc.add(MoveForwardEvent(
                          tab: 2,
                          tabSliderBloc: _tabsliderBloc,
                          bookBloc: _bookBloc));
                      _bookBloc.add(DisposeBookEvent());
                      _bookBloc.add(GetBookEvent());
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
