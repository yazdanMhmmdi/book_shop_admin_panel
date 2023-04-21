import 'package:book_shop_admin_panel/presentation/widgets/toast_widget.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  ButtonState buttonState = ButtonState.idle;
  var backgroundColor = IColors.green;
  AuthBloc? authBloc;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          await delay(seconds: 2);
          Navigator.pushNamed(context, '/categorypage');
        } else if (state is AuthFailure) {
          ToastWidget.showError(context, title: "خطا", desc: state.message);
        }
      },
      child: Scaffold(
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
                        offset: const Offset(-1, 0),
                        blurRadius: 3,
                        color: IColors.black15,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
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
                      const SizedBox(
                        height: 16,
                      ),
                      LoginTextField(
                        obscureText: false,
                        lengthLimiting: 20,
                        iconData: Icons.person,
                        hintText: "نام کاربری...",
                        textEditingController: _userController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      LoginTextField(
                        obscureText: true,
                        iconData: Icons.lock,
                        lengthLimiting: 12,
                        hintText: "رمزعبور...",
                        textEditingController: _passwordController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthSuccess) {
                            return buttonUI(ButtonState.success);
                          } else if (state is AuthLoading) {
                            return buttonUI(ButtonState.loading);
                          } else if (state is AuthFailure) {
                            return buttonUI(ButtonState.fail);
                          } else {
                            return buttonUI(ButtonState.idle);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> delay({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  Widget buttonUI(ButtonState buttonState) {
    return MyButton(
        buttonState: buttonState,
        text: "تایید",
        onTap: () {
          authBloc!.add(LoginEvent(
              password: _passwordController.text,
              username: _userController.text));
        });
  }

  initPage() {
    authBloc = BlocProvider.of<AuthBloc>(context);
  }
}
