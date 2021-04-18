import 'package:book_shop_admin_panel/constants/assets.dart';
import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/presentation/widget/background_shapes.dart';
import 'package:book_shop_admin_panel/presentation/widget/login_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.green,
      body: Stack(
        children: [
          BackgroundShapes(),
          Center(
            child: Container(
              width: 348,
              height: 256,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-1, 0),
                      blurRadius: 3,
                      color: IColors.black15,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      "ورود ادمین",
                      style: TextStyle(
                          fontFamily: "IranSans",
                          fontSize: 18,
                          color: IColors.black85,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    LoginTextField(hintText: "نام کاربری..."),
                    SizedBox(
                      height: 16,
                    ),
                    LoginTextField(hintText: "رمزعبور..."),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 46,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: IColors.boldGreen,
                      ),
                      child: Center(
                        child: Text(
                          "تایید",
                          style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: IColors.white90),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
