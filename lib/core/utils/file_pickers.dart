import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../presentation/widgets/global_class.dart';
import '../constants/assets.dart';
import '../constants/strings.dart';

class FilePickers {
  FilePickerResult? filePickerResult;
  FilePickers();

  Future<File> pickImage() async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'ong', 'jpeg'],
      dialogTitle: Strings.filePickerPleasePickaFile,
    );
    if (filePickerResult != null) {
      File file = File(filePickerResult!.files.single.path!);
      return file;
    } else {
      // User canceled the picker
      return GlobalClass.file ?? File(Assets.bookPlaceHolder);
    }
  }

  Future<File> pickAPK() async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
      dialogTitle: Strings.filePickerPleasePickaAPKFile,
    );
    if (filePickerResult != null) {
      File file = File(filePickerResult!.files.single.path!);
      return file;
    } else {
      // User canceled the picker
      return GlobalClass.file ?? File(Assets.bookPlaceHolder);
    }
  }
}
