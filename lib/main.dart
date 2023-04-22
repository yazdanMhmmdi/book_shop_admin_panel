import 'package:flutter/material.dart';

import 'core/constants/strings.dart';
import 'injector.dart';
import 'presentation/router/app_router.dart';

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
        fontFamily: Strings.fontIranSans,
      ),
      onGenerateRoute: _router.onGeneratedRoute,
    );
  }
}
