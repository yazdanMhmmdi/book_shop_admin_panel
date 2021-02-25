import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => PanelScreen());
        break;

      default:
        return null;
    }
  }
}
