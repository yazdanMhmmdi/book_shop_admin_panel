import 'dart:ffi';

import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/data/model/category_model.dart';
import 'package:book_shop_admin_panel/logic/bloc/category_bloc.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:book_shop_admin_panel/presentation/widget/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/books_item.dart';
import 'package:book_shop_admin_panel/presentation/widget/delete_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_book_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksTab extends StatefulWidget {
  static int clickStatus;
  List<int> a = new List<int>();

  @override
  _BooksTabState createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  CategoryBloc _categoryBloc;
  ApiProvider _apiProvider = new ApiProvider();
  @override
  void initState() {
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    widget.a.add(0);
    widget.a.add(1);
  }

  @override
  Widget build(BuildContext context) {
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryInitial) {
              return Container();
            } else if (state is CategoryLoading) {
              return Container();
            } else if (state is CategorySuccess) {
              List items = new List<Widget>();
              state.categoryModel.books.forEach((element) {
                items.add(
                  BooksItem(
                    number: 1,
                    image: "http://localhost${element.pictureThumb}",
                    title: element.name,
                    writer: element.writer,
                    rate: double.parse(element.voteCount),
                    id: element.id,
                    onTap: () {
                      setState(() {
                        BooksTab.clickStatus = 1;
                        print('xx2');
                      });
                    },
                  ),
                );
              });
              return Wrap(children: items);
            } else if (state is CategoryLazyLoading) {
              List items = new List<Widget>();
              state.categoryModel.books.forEach((element) {
                items.add(
                  BooksItem(
                    number: 1,
                    image: "http://localhost${element.pictureThumb}",
                    title: element.name,
                    writer: element.writer,
                    rate: double.parse(element.voteCount),
                    id: element.id,
                    onTap: () {
                      setState(() {
                        BooksTab.clickStatus = 1;
                        print('xx2');
                      });
                    },
                  ),
                );
              });
              return Wrap(children: items);
            } else if (state is CategoryFailure) {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

/*
BooksItem(
              number: 1,
              image: Image.asset(Assets.image_1),
              title: "کتاب دوراهی",
              writer: "جودی پیکلت",
              rate: 3.0,
              id: "23",
              onTap: () {
                setState(() {
                  BooksTab.clickStatus = 1;
                  print('xx2');
                });
              },
            ),

*/
