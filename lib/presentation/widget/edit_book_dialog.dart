import 'dart:io';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/widget/multi_text_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/text_field_spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_picker_spot.dart';

class EditBookDialog extends StatefulWidget {
  static File file;
  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  BookBloc _bookBloc;

  String name;

  String writer;

  String description;

  String language;

  String coverType;

  String pageCount;

  String vote;

  @override
  void initState() {
    super.initState();
    _bookBloc = BlocProvider.of<BookBloc>(context);
    _bookBloc.add(ReturnSelectedBookEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, -1),
              blurRadius: 4,
              spreadRadius: 0,
              color: IColors.black15,
            ),
          ]),
      child: BlocBuilder<BookBloc, BookState>(
          cubit: _bookBloc,
          builder: (context, state) {
            if (state is BookInitial) {
              return Container();
            } else if (state is BookSelectedReturn) {
              return Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      children: [
                        new TextFieldSpot(
                          onChanged: (value) {
                            setState(() {
                              writer = value;
                            });
                          },
                          initialValue: state.writer,
                          title: "نویسنده",
                          maxLengh: 50,
                          width: 377,
                        ),
                        SizedBox(width: 16),
                        TextFieldSpot(
                          initialValue: state.name,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          width: 377,
                          title: "موضوع کتاب",
                          maxLengh: 82,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    MultiTextFieldSpot(
                      initialValue: state.description,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      maxLengh: 560,
                      title: "توضیحات",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      children: [
                        TextFieldSpot(
                          initialValue: state.coverType,
                          onChanged: (value) {
                            setState(() {
                              coverType = value;
                            });
                          },
                          maxLengh: 10,
                          width: 377,
                          title: "نوع جلد",
                        ),
                        SizedBox(width: 16),
                        TextFieldSpot(
                          initialValue: state.language,
                          onChanged: (value) {
                            setState(() {
                              language = value;
                            });
                          },
                          maxLengh: 15,
                          width: 377,
                          title: "زبان  ",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      children: [
                        TextFieldSpot(
                          initialValue: state.voteCount,
                          width: 377,
                          title: "رای  ",
                          onChanged: (value) {
                            setState(() {
                              vote = value;
                            });
                          },
                          maxLengh: 6,
                        ),
                        SizedBox(width: 16),
                        TextFieldSpot(
                          initialValue: state.pageCount,
                          width: 377,
                          title: "تعداد صفحات",
                          onChanged: (value) {
                            setState(() {
                              pageCount = value;
                            });
                          },
                          maxLengh: 5,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ImagePickerSpot(
                      onFilePicked: (file) {
                        EditBookDialog.file = file;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "اگر عکسی انتخاب نکنید عکس قبلی به عنوان پیش فرض قرار خواهد گرفت.",
                      style: TextStyle(
                          color: IColors.black35,
                          fontSize: 14,
                          fontFamily: "IranSans",
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 38,
                      width: 770,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: IColors.boldGreen,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            _bookBloc.add(EditBookEvent(
                              book_id: PanelScreen.status.toString(),
                              name: name,
                              language: language,
                              description: description,
                              coverType: coverType,
                              vote: vote,
                              file: EditBookDialog.file,
                              pageCount: pageCount,
                              writer: writer,
                            ));
                            _bookBloc.add(DisposeBookEvent());
                            _bookBloc.add(GetBookEvent(category_id: "1"));
                          },
                          child: Center(
                            child: Text(
                              "ثبت کتاب",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "IranSans",
                                  fontSize: 16,
                                  color: Colors.white70,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  void updateFile(File newFile) {
    setState(() {
      EditBookDialog.file = newFile;
    });
  }
}
