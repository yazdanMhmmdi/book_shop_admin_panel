import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginTextFieldMobile extends StatefulWidget {
  var icon;
  var text;
  var obscureText;
  Color textFieldColor;
  TextEditingController controller;
  LoginTextFieldMobile(
      {required this.controller,
      required this.obscureText,
      required this.icon,
      required this.text,
      required this.textFieldColor});

  @override
  _LoginTextFieldMobileState createState() => _LoginTextFieldMobileState();
}

class _LoginTextFieldMobileState extends State<LoginTextFieldMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.textFieldColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(widget.icon, color: Colors.grey),
                    onPressed: () {}),
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    obscureText: widget.obscureText,
                    validator: (value) {
                      if (value == "") {
                        return "yes";
                      }
                      return "no";
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "IranSans",
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '${widget.text}',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z0-9]+$')),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 16),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'نام کاربری'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
