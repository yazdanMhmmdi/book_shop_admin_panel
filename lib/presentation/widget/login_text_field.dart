import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  TextEditingController textEditingController;
  String hintText;
  LoginTextField({this.hintText, this.textEditingController});
  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: widget.textEditingController,
                decoration: InputDecoration(
                  fillColor: IColors.green,
                  border: InputBorder.none,
                  hintText: "${widget.hintText}",
                  hintStyle: TextStyle(
                      fontFamily: "IranSans",
                      fontSize: 16,
                      color: IColors.black55),
                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.person, color: IColors.black55),
              onPressed: () {}),
          SizedBox(
            width: 4,
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: IColors.lowBoldGreen,
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
