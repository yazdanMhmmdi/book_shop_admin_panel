import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import 'login_page_desktop.dart';
import 'login_page_mobile.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Responsive(
      mobile: LoginPageMobile(),
      desktop: LoginPageDesktop(),
    );
  }
}
