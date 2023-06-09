// ignore_for_file: must_be_immutable

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';

class PriceTextFieldMobile extends StatefulWidget {
  var icon;
  var text;
  var obscureText;
  Color textFieldColor;
  double width;
  Function(String)? onChanged;
  TextEditingController controller;
  int? maxLengh;
  PriceTextFieldMobile({
    required this.controller,
    required this.obscureText,
    required this.icon,
    required this.text,
    required this.textFieldColor,
    required this.width,
    this.onChanged,
    this.maxLengh = 10,
  });

  @override
  _PriceTextFieldMobileState createState() => _PriceTextFieldMobileState();
}

class _PriceTextFieldMobileState extends State<PriceTextFieldMobile> {
  @override
  void initState() {
    widget.onChanged ??= widget.onChanged = (v) {
      return '';
    };
    widget.maxLengh ??= 10;

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
                    // FilteringTextInputFormatter.allow(
                    //     RegExp(r'^[a-zA-Z0-9]+$')),
                    LengthLimitingTextInputFormatter(
                      widget.maxLengh,
                    ),
                    CurrencyTextInputFormatter(
                      customPattern: customCurrencyPattern,
                      decimalDigits: 0,
                    ),
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
