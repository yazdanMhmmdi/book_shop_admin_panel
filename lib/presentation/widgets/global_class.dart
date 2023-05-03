import 'dart:io';

import '../../core/constants/assets.dart';

class GlobalClass {
  static int pickedBookId = 0;
  static int pickedUserId = 0;
  static String currentCategoryId = "1";

  static File? file = File(Assets.bookPlaceHolder);
}
