import 'dart:io';

import '../../core/constants/assets.dart';
import '../../core/utils/image_address_provider.dart';
import 'global_class.dart';
import 'package:flutter/material.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import 'package:flutter/services.dart';

typedef void DynamicCallback(File file);

class ImagePickerWidget extends StatefulWidget {
  final DynamicCallback onFilePicked;
  String? imgUrl;
  File? image = File(Assets.bookPlaceHolder);
  ImagePickerWidget({required this.onFilePicked, this.imgUrl});

  @override
  _ImagePickerSpotState createState() => _ImagePickerSpotState();
}

class _ImagePickerSpotState extends State<ImagePickerWidget> {
  @override
  void initState() {
    try {
      if (widget.imgUrl!.isNotEmpty) {
        _fileFromImageUrl(ImageAddressProvider.getAddress(widget.imgUrl!))
            .then((fFile) {
          setState(() {
            //set default file value
            widget.image = fFile;
            GlobalClass.file = fFile;
          });
        });
      }
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  Future<File> _fileFromImageUrl(String url) async {
    imageCache.clear();

    var response = await http.get(Uri.parse(url));

    var documentDirectory = await getApplicationDocumentsDirectory();

    File file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

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
            widget.image = f.getFile() ?? widget.image;

            widget.onFilePicked(widget.image!);

            GlobalClass.file = widget.image;
            setState(() {});
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
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: FileImage(widget.image!),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load("assets/$path");

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
