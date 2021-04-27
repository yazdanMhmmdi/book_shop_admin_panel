import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widget/post_custom_painter.dart';
import 'package:book_shop_admin_panel/presentation/widget/slider_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDialog extends StatefulWidget {
  @override
  _PostDialogState createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  BookBloc _bookBloc;
  @override
  void initState() {
    _bookBloc = BlocProvider.of<BookBloc>(context);
    _bookBloc.add(ReturnSelectedBookEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookSelectedReturn) {
          return objects(state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget objects(var state) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 134,
              height: 111,
              child: CustomPaint(
                painter: PostCustomPainter(),
              ),
            ),
            Container(
                width: 737,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${state.writer}",
                          style: TextStyle(
                            fontFamily: Strings.fontIranSans,
                            fontSize: 16,
                            color: IColors.black35,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${state.name}",
                          style: TextStyle(
                            fontFamily: Strings.fontIranSans,
                            fontSize: 18,
                            color: IColors.black85,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: SliderObject(
                            coverType: "${state.coverType}",
                            voteCount: "${state.voteCount}",
                            pageCount: "${state.pageCount}",
                            language: "${state.language}"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.postDialogdesc,
                              style: TextStyle(
                                fontFamily: Strings.fontIranSans,
                                fontSize: 20,
                                color: IColors.black85,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              state.description,
                              style: TextStyle(
                                fontFamily: Strings.fontIranSans,
                                fontSize: 16,
                                color: IColors.black35,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "http://localhost${state.picture}",
                    ),
                    fit: BoxFit.fill),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              width: 100,
              height: 158,
            ),
          ],
        ),
      ],
    );
  }
}
