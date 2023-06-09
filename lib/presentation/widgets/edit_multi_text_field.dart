// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditMultiTextField extends StatefulWidget {
  var icon;
  var text;
  var obscureText;
  Color textFieldColor;
  double width;
  int? maxLengh;
  TextEditingController controller;
  EditMultiTextField({
    required this.controller,
    required this.obscureText,
    required this.icon,
    required this.text,
    required this.textFieldColor,
    required this.width,
    this.maxLengh = 255,
  });

  @override
  _EditMultiTextFieldState createState() => _EditMultiTextFieldState();
}

class _EditMultiTextFieldState extends State<EditMultiTextField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: widget.width,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.textFieldColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(widget.icon, color: Colors.grey),
                  onPressed: () {}),
              Expanded(
                child: TextFormField(
                  maxLines: 4,
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
                    LengthLimitingTextInputFormatter(widget.maxLengh),
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
    );
  }
}
