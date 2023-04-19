import 'package:book_shop_admin_panel/core/constants/strings.dart';

class MapRuleTypes {
  MapRuleTypes._();

  static String returnRule(dynamic title) {
    switch (title) {
      case Strings.ruleAdminTitle:
        return Strings.ruleAdmin;
      case Strings.ruleUserTitle:
        return Strings.ruleUser;
      default:
        return Strings.ruleUser;
    }
  }

  static String returnTitle(dynamic rule) {
    switch (rule) {
      case Strings.ruleAdmin:
        return Strings.ruleAdminTitle;
      case Strings.ruleUser:
        return Strings.ruleUserTitle;
      default:
        return Strings.ruleAdminTitle;
    }
  }
}
