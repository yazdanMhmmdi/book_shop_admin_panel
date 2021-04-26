import 'dart:ffi';

import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/data/model/book_model.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/widget/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/books_item.dart';
import 'package:book_shop_admin_panel/presentation/widget/delete_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/edit_book_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BooksTab extends StatefulWidget {
  static int clickStatus;
  List<int> a = new List<int>();

  @override
  _BooksTabState createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  BookBloc _bookBloc;
  ApiProvider _apiProvider = new ApiProvider();
  @override
  void initState() {
    _bookBloc = BlocProvider.of<BookBloc>(context);

    widget.a.add(0);
    widget.a.add(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookInitial) {
              return Container();
            } else if (state is BookLoading) {
              return Container();
            } else if (state is BookSuccess) {
              List items = new List<Widget>();
              state.bookModel.books.forEach((element) {
                items.add(returnCard(element));
              });
              return Wrap(children: items);
            } else if (state is BookLazyLoading) {
              List items = new List<Widget>();
              state.bookModel.books.forEach((element) {
                items.add(returnCard(element));
              });
              return Wrap(children: items);
            } else if (state is BookSearchLazyLoading) {
              List items = new List<Widget>();
              state.bookModel.books.forEach((element) {
                items.add(returnCard(element));
              });
              return Wrap(children: items);
            } else if (state is BookSelectedReturn) {
              List items = new List<Widget>();
              state.bookModel.books.forEach((element) {
                items.add(returnCard(element));
              });
              return Wrap(children: items);
            } else if (state is BookEmpty) {
              return Container(
                child: Center(
                  child: Text(
                    "کتابی وجود ندارد",
                    style: TextStyle(
                        color: IColors.black55,
                        fontFamily: "IranSans",
                        fontSize: 16),
                  ),
                ),
              );
            } else if (state is BookFailure) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget returnCard(var element) {
    return BooksItem(
      number: int.tryParse(element.id),
      image: "http://localhost${element.pictureThumb}",
      title: element.name,
      writer: element.writer,
      rate: double.tryParse(element.voteCount),
      id: element.id,
      onTap: () {
        setState(() {
          BooksTab.clickStatus = int.tryParse(element.id);
          PanelScreen.status = int.tryParse(element.id);
          //selected book that user choosed it.
          _bookBloc.add(SelectBookEvent(book_id: element.id.toString()));
          
          print('selected book: ${PanelScreen.status}');
        });
      },
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
