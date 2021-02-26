import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/presentation/widget/add_book_dialog.dart';
import 'package:book_shop_admin_panel/presentation/widget/books_item.dart';
import 'package:flutter/material.dart';

class BooksTab extends StatefulWidget {
  static int clickStatus;
  List<int> a = new List<int>();

  @override
  _BooksTabState createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  @override
  void initState() {
    widget.a.add(0);
    widget.a.add(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Wrap(
          children: [
            BooksItem(
              number: 0,
              image: Image.asset(Assets.image_1),
              title: "کتاب دوراهی",
              writer: "جودی پیکلت",
              rate: 3.0,
              id: "23",
              onTap: () {
                setState(() {
                  BooksTab.clickStatus = 0;
                  print('xx1');
                  showGeneralDialog(
                    barrierLabel: "Barrier",
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: Duration(milliseconds: 300),
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return Align(
                        alignment: Alignment.center,
                        child: AddBookDialog(),
                      );
                    },
                    transitionBuilder: (_, anim, __, child) {
                      return SlideTransition(
                        position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                            .animate(anim),
                        child: child,
                      );
                    },
                  );
                });
              },
            ),
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
          ],
        ),
      ),
    );
  }
}
