//  API URL
import 'package:book_shop_admin_panel/core/constants/strings.dart';

import 'assets.dart';

const String? kBaseApiUrl = "http://yazdanmohammadi.ir";

const String? kAdminApiUrl = "http://yazdanmohammadi.ir/book_shop/v1.1/api/admin";

const String kServerFailureMessage = 'server failure';

const String kCacheFailureMessage = 'cache failure';

const String customCurrencyPattern = "###,### تومان";

const String customThreeDigitsPattern = "###,###";

RegExp kValidCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

const int kAnimationDuration = 350;

const List<Map<String, String>> ruleTypes = [
  {
    "rule": Strings.ruleAdmin,
    "title": Strings.ruleAdminTitle,
  },
  {
    "rule": Strings.ruleUser,
    "title": Strings.ruleUserTitle,
  }
];
const List<Map<String, String>> categoryList = [
  {
    'title': Strings.categoryOptionSicence,
    'image': Assets.labTool,
    'category_id': "1",
  },
  {
    'title': Strings.categoryOptionMedicine,
    'image': Assets.medicine,
    'category_id': "2",
  },
  {
    'title': Strings.categoryOptionHistory,
    'image': Assets.hourglass,
    'category_id': "3",
  },
  {
    'title': Strings.categoryOptionJudiciary,
    'image': Assets.auction,
    'category_id': "4",
  },
  {
    'title': Strings.categoryOptionFoods,
    'image': Assets.dish,
    'category_id': "5",
  },
];
