import 'dart:io';

import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:book_shop_admin_panel/presentation/widget/add_book_dialog.dart';
import 'package:flutter/material.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:http/http.dart';

typedef void DynamicCallback(File file);

class ImagePickerSpot extends StatefulWidget {
  final DynamicCallback onFilePicked;
  ImagePickerSpot({@required this.onFilePicked});

  @override
  _ImagePickerSpotState createState() => _ImagePickerSpotState();
}

class _ImagePickerSpotState extends State<ImagePickerSpot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 131,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: IColors.lowBoldGreen,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.black26,
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            final f = OpenFilePicker()
              ..filterSpecification = {
                'Image (*.jpg; *.png; *.jpeg)': '*.jpg;*.png;*.jpeg',
              }
              ..defaultFilterIndex = 0
              ..defaultExtension = 'png'
              ..title = 'Select a picture';
            widget.onFilePicked(f.getFile());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "انتخاب عکس",
                style: TextStyle(
                  fontFamily: Strings.fontIranSans,
                  fontSize: 16,
                  color: IColors.black85,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
