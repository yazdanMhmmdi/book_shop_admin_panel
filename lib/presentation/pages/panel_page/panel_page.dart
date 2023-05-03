import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import 'panel_page_desktop.dart';
import 'panel_page_mobile.dart';

class PanelPage extends StatelessWidget {
  const PanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: PanelPageMobile(),
      desktop: PanelPageDesktop(),
    );
  }
}
