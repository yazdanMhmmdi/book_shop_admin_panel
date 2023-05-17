import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';

class EditTextField extends StatefulWidget {
  var icon;
  var text;
  var obscureText;
  Color textFieldColor;
  double width;
  Function(String)? onChanged;
  TextEditingController controller;
  bool? isOnlyDigit;
  int? maxLengh;
  bool threeDigitSeperator;

  EditTextField({
    required this.controller,
    required this.obscureText,
    required this.icon,
    required this.text,
    required this.textFieldColor,
    required this.width,
    this.onChanged,
    this.isOnlyDigit = false,
    this.maxLengh = 30,
    this.threeDigitSeperator = false,
  });

  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  @override
  void initState() {
    widget.onChanged ??= widget.onChanged = (v) {
      return '';
    };
    widget.isOnlyDigit ??= false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: widget.width,
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
                  onChanged: widget.onChanged,
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
                    widget.threeDigitSeperator
                        ? CurrencyTextInputFormatter(
                            customPattern: customThreeDigitsPattern,
                            decimalDigits: 0,
                          )
                        : FilteringTextInputFormatter.singleLineFormatter,
                    // FilteringTextInputFormatter.allow(
                    //     RegExp(r'^[a-zA-Z0-9]+$')),
                    widget.isOnlyDigit!
                        ? FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9]+\.?[0-9]*'))
                        : FilteringTextInputFormatter.singleLineFormatter,
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
