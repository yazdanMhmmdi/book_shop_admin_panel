import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/data/model/category_model.dart';
import 'package:book_shop_admin_panel/data/repository/category_repository.dart';
import 'package:book_shop_admin_panel/logic/bloc/category_bloc.dart';
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
  CategoryBloc _categoryBloc;
  @override
  void initState() {
    _tabsliderBloc = BlocProvider.of<TabsliderBloc>(context);
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _tabsliderBloc.add(MoveForwardEvent(
        tab: 0, tabSliderBloc: _tabsliderBloc, categoryBloc: _categoryBloc));
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
                        _tabsliderBloc.add(MoveForwardEvent(
                            tab: 2,
                            tabSliderBloc: _tabsliderBloc,
                            categoryBloc: _categoryBloc));
                        _categoryBloc.add(DisposeCategoryEvent());
                        _categoryBloc.add(GetCategoryEvent(category_id: "1"));
                      }),
                  CategoryItem(
                    child: Image.asset(Assets.medicine),
                    title: "دارویی",
                    onTap: () {
                      _tabsliderBloc.add(MoveForwardEvent(
                          tab: 2,
                          tabSliderBloc: _tabsliderBloc,
                          categoryBloc: _categoryBloc));
                      _categoryBloc.add(DisposeCategoryEvent());
                      _categoryBloc.add(GetCategoryEvent(category_id: "2"));
                    },
                  ),
                  CategoryItem(
                    child: Image.asset(Assets.hourglass),
                    title: "تاریخی",
                  ),
                  CategoryItem(
                    child: Image.asset(Assets.auction),
                    title: "قضایی",
                  ),
                  CategoryItem(
                    child: Image.asset(Assets.dish),
                    title: "غذایی",
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
