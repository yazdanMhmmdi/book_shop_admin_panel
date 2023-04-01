import 'package:book_shop_admin_panel/presentation/router/app_router.dart';
import 'package:flutter/material.dart';

import 'injector.dart';

void main() async {
  await init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppRouter _router = AppRouter();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _router.onGeneratedRoute,
    );
  }
}
