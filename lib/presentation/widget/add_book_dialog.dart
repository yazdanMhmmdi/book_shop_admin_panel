import 'dart:io';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:book_shop_admin_panel/presentation/widget/multi_text_field_spot.dart';
import 'package:book_shop_admin_panel/presentation/widget/text_field_spot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'image_picker_spot.dart';

class AddBookDialog extends StatefulWidget {
  static File file;

  @override
  _AddBookDialogState createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
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
                TextFieldSpot(
                  width: 377,
                  title: "نویسنده",
                  maxLengh: 50,
                ),
                SizedBox(width: 16),
                TextFieldSpot(
                  width: 377,
                  title: "موضوع کتاب",
                  maxLengh: 82,
                ),
              ],
            ),
            SizedBox(height: 16),
            MultiTextFieldSpot(
              maxLengh: 560,
              title: "توضیحات",
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                TextFieldSpot(
                  width: 377,
                  title: "نوع جلد",
                  maxLengh: 10,
                ),
                SizedBox(width: 16),
                TextFieldSpot(
                  width: 377,
                  title: "زبان  ",
                  maxLengh: 15,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                TextFieldSpot(
                  width: 377,
                  title: "رای  ",
                  maxLengh: 6,
                ),
                SizedBox(width: 16),
                TextFieldSpot(
                  width: 377,
                  title: "تعداد صفحات",
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
                  ApiProvider _api = ApiProvider();

                  ApiProvider apiProvider = ApiProvider();
                  apiProvider.post('admin_add_books.php', AddBookDialog.file);
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
                          fontFamily: "IranSans",
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

  void updateFile(File newFile) {
    setState(() {
      AddBookDialog.file = newFile;
    });
  }
}
