import '../constants/strings.dart';

class MapCategories {
  MapCategories._();
  static String returnNumber(String value) {
    switch (value) {
      case Strings.categoryOptionSicence:
        return '1';

      case Strings.categoryOptionMedicine:
        return '2';

      case Strings.categoryOptionHistory:
        return '3';

      case Strings.categoryOptionJudiciary:
        return '4';

      case Strings.categoryOptionFoods:
        return '5';
      default:
        return '1';
    }
  }

  static String returnTitle(String value) {
    switch (value) {
      case '1':
        return Strings.categoryOptionSicence;

      case '2':
        return Strings.categoryOptionMedicine;

      case '3':
        return Strings.categoryOptionHistory;

      case '4':
        return Strings.categoryOptionJudiciary;

      case '5':
        return Strings.categoryOptionFoods;
      default:
        return Strings.categoryOptionSicence;
    }
  }
}
