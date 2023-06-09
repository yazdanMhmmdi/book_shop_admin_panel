// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../core/constants/i_colors.dart';
import '../../core/constants/strings.dart';

class CustomDropdownWidget extends StatefulWidget {
  Function(String) selectedValueChange;
  String? selectedValue;
  String? title;
  List<String> optionList = <String>['فیزیکی', 'دیجیتال'];
  double width;

  CustomDropdownWidget({
    Key? key,
    required this.selectedValueChange,
    this.selectedValue = "",
    required this.title,
    required this.optionList,
    this.width = 377,
  }) : super(key: key);

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title != ""
            ? Text(
                widget.title!,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Strings.fontIranSans,
                    color: IColors.black85,
                    decoration: TextDecoration.none),
              )
            : Container(),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: widget.width,
          height: 35,
          color: IColors.lowBoldGreen,
          child: Material(
            borderRadius: BorderRadius.circular(8),
            child: DropdownButtonFormField2(
              value: widget.selectedValue!,
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: const Text(
                'نوع جلد را انتخاب کنید...',
                style: TextStyle(fontSize: 14),
              ),
              items: widget.optionList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              item,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'نوع جلد را انتخاب کنید...';
                }
                return null;
              },
              onChanged: (value) {
                widget.selectedValueChange.call(value!);
              },
              onSaved: (value) {
                widget.selectedValue = value.toString();
              },
              buttonStyleData: ButtonStyleData(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: IColors.lowBoldGreen,
                    borderRadius: BorderRadius.circular(8),
                  )),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                direction: DropdownDirection.right,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
