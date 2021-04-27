import 'dart:ffi';
import 'dart:io';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/data/repository/book_repository.dart';
import 'package:book_shop_admin_panel/logic/bloc/book_bloc.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:book_shop_admin_panel/presentation/widget/multi_text_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/text_field_spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'image_picker_spot.dart';

class AddBookDialog extends StatefulWidget {
  static File file;

  @override
  _AddBookDialogState createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
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
    _bookBloc = BlocProvider.of<BookBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              children: [
                textField("نویسنده", 377, _writerController, 50),
                SizedBox(width: 16),
                textField("موضوع کتاب", 377, _nameController, 82),
              ],
            ),
            SizedBox(height: 16),
            multiTextField("توضیحات", _descriptionController, 560),

            SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                textField("نوع جلد", 377, _coverTypeController, 10),
                SizedBox(width: 16),
                textField("زبان  ", 377, _languageController, 15),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                textField("رای  ", 377, _voteCountController, 6),
                SizedBox(width: 16),
                textField("تعداد صفحات", 377, _pageCountController, 5),
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
                updateFile(file);
              },
            ),
            SizedBox(
              height: 16,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  _bookBloc.add(AddBookEvent(
                    category_id: "1",
                    name: _nameController.text,
                    language: _languageController.text,
                    description: _descriptionController.text,
                    coverType: _coverTypeController.text,
                    vote: _voteCountController.text,
                    file: AddBookDialog.file,
                    pageCount: _pageCountController.text,
                    writer: _writerController.text,
                  ));
                  _bookBloc.add(DisposeBookEvent());
                  _bookBloc.add(GetBookEvent());
                  Navigator.pop(context);
                  // if (AddBookDialog.file != null) {

                  //   Response res = await _api.post("admin_add_books.php", file);
                  //   print(res);

                  //   print(file.path);
                  // }
                },
                child: Container(
                  height: 35,
                  width: 770,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: IColors.boldGreen,
                  ),
                  child: Center(
                    child: Text(
                      "ثبت کتاب",
                      style: TextStyle(
                          fontFamily: Strings.fontIranSans,
                          fontSize: 14,
                          color: Colors.white70,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
            ),
            // Image.file(AddBookDialog.file,width: 100, height: 100,),
          ],
        ),
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
                style:
                    TextStyle(fontFamily: Strings.fontIranSans, fontSize: 16),
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

  void updateFile(File newFile) {
    setState(() {
      AddBookDialog.file = newFile;
    });
  }
}
