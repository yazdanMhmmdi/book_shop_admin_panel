import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';

class PriceTextField extends StatefulWidget {
  PriceTextField({
    Key? key,
    required this.title,
    this.width = 377,
    required this.controller,
    this.maxLengh = 10,
    this.textInputType,
  }) : super(key: key);
  final String title;
  final double width;
  final int maxLengh;
  final TextInputType? textInputType;
  final TextEditingController controller;

  @override
  State<PriceTextField> createState() => _PriceTextFieldState();
}

class _PriceTextFieldState extends State<PriceTextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${widget.title}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: Strings.fontIranSans,
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 8,
        ),
        Material(
          child: Container(
            height: 35,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                  child: TextField(
                controller: widget.controller,
                maxLines: 1,
                keyboardType: widget.textInputType,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(
                    int.parse(widget.maxLengh.toString()),
                  ),
                  CurrencyTextInputFormatter(
                    customPattern: customCurrencyPattern,
                    decimalDigits: 0,
                  ),
                ],
                style: const TextStyle(fontFamily: 'IranSans', fontSize: 16),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 16, right: 16, left: 16)),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
