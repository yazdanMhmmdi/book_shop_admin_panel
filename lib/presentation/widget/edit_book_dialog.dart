import 'dart:io';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/widget/multi_text_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/text_field_spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _writerController = new TextEditingController();
  TextEditingController _coverTypeController = new TextEditingController();
  TextEditingController _languageController = new TextEditingController();

  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _voteCountController = new TextEditingController();
  TextEditingController _pageCountController = new TextEditingController();
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
      child: BlocBuilder<BookBloc, BookState>(builder: (context, state) {
        if (state is BookInitial) {
          return Container();
        } else if (state is BookSelectedReturn) {
          return objects(state);
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

  Widget objects(dynamic state) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              textField(
                  "نویسنده", 377, _writerController..text = state.writer, 50),
              SizedBox(width: 16),
              textField(
                  "موضوع کتاب", 377, _nameController..text = state.name, 50)
            ],
          ),
          SizedBox(height: 16),
          multiTextField(
              "توضیحات", _descriptionController..text = state.description, 560),
          SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              textField("نوع جلد", 377,
                  _coverTypeController..text = state.coverType, 10),
              SizedBox(width: 16),
              textField("زبان  ", 377,
                  _languageController..text = state.language, 15),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              textField("رای  ", 377,
                  _voteCountController..text = state.voteCount, 6),
              SizedBox(width: 16),
              textField("تعداد صفحات", 377,
                  _pageCountController..text = state.pageCount, 5),
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
                fontFamily: Strings.fontIranSans,
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
                    name: _nameController.text,
                    language: _languageController.text,
                    description: _descriptionController.text,
                    coverType: _coverTypeController.text,
                    vote: _voteCountController.text,
                    file: EditBookDialog.file,
                    pageCount: _pageCountController.text,
                    writer: _writerController.text,
                  ));
                  _bookBloc.add(DisposeBookEvent());
                  _bookBloc.add(GetBookEvent());
                  setState(() {
                    EditBookDialog.file = null;
                  });
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    "ثبت کتاب",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: Strings.fontIranSans,
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
  }

  Widget textField(
      String title, double width, TextEditingController controller, maxLengh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: Strings.fontIranSans,
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 8,
        ),
        Material(
          child: Container(
            height: 35,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                  child: TextField(
                controller: controller,
                onChanged: (val) {
                  // //widget.onChanged(val);
                  // //widget.onChanged(val);
                  // setState(() {
                  //   controller.text = val;
                  // });
                },
                maxLines: 2,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(maxLengh),
                ],
                style: TextStyle(fontFamily: 'IranSans', fontSize: 16),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 4, right: 16, left: 16)),
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget multiTextField(
      String title, TextEditingController controller, int maxLengh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: Strings.fontIranSans,
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 8,
        ),
        Material(
          color: Colors.transparent,
          child: Container(
            height: 92,
            width: 770,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  maxLines: 3,
                  controller: controller,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(maxLengh),
                  ],
                  style:
                      TextStyle(fontFamily: Strings.fontIranSans, fontSize: 16),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          bottom: 11, right: 16, left: 16, top: 11)),
                )),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
