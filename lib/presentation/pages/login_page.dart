import 'package:book_shop_admin_panel/presentation/widgets/progress_button.dart';
import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';
import '../widgets/background_shapes.dart';
import '../widgets/login_text_field.dart';
import '../widgets/my_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userController = new TextEditingController();

  TextEditingController _passwordController = new TextEditingController();

  ButtonState buttonState = ButtonState.idle;

  var backgroundColor = IColors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      "ورود ادمین",
                      style: TextStyle(
                          fontFamily: Strings.fontIranSans,
                          fontSize: 18,
                          color: IColors.black85,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    LoginTextField(
                      obscureText: false,
                      lengthLimiting: 20,
                      iconData: Icons.person,
                      hintText: "نام کاربری...",
                      textEditingController: _userController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    LoginTextField(
                      obscureText: true,
                      iconData: Icons.lock,
                      lengthLimiting: 12,
                      hintText: "رمزعبور...",
                      textEditingController: _passwordController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MyButton(
                      text: "تایید",
                      onTap: () {
                        // _loginBloc!.add(LogUserInEvent(
                        //     username: _userController.text,
                        //     password: _passwordController.text));
                      },
                      buttonState: buttonState,
                    ),
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
