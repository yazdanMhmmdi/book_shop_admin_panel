import 'dart:io';

import 'package:book_shop_admin_panel/presentation/widgets/custom_scroll_behavior.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';

class ApkPickerMobile extends StatefulWidget {
  Function(File apk)? onApkPicked;
  ApkPickerMobile({Key? key, required this.onApkPicked}) : super(key: key);

  @override
  State<ApkPickerMobile> createState() => _ApkPickerMobileState();
}

class _ApkPickerMobileState extends State<ApkPickerMobile> {
  File? apkFile;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: IColors.lowBoldGreen),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 125,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 11, 8, 11),
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: IColors.boldGreen,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              print('انتخاب فایل');
                              final f = OpenFilePicker()
                                ..filterSpecification = {
                                  'Apk File (*.apk;)': '*.apk;',
                                }
                                ..defaultFilterIndex = 0
                                ..defaultExtension = 'apk'
                                ..title = 'فایل apk را انتخاب کنید';
                              apkFile = f.getFile() ?? apkFile;
                              if (apkFile != null) {
                                widget.onApkPicked!(apkFile!);
                                setState(() {});
                              }
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: IColors.white90,
                                  ),
                                  child: ClipOval(
                                    child: Center(
                                      child: Icon(
                                        apkFile == null
                                            ? Icons.close
                                            : Icons.check,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  Strings.apkPickerPickFile,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: IColors.white90,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      apkFile == null ? "" : apkFile!.path,
                      textAlign: TextAlign.left,
                      softWrap: false,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        color: IColors.black35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
