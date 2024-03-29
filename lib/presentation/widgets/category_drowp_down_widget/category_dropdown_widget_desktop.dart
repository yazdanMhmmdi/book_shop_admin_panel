// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/map_categories.dart';

class CategoryDropdownWidgetDesktop extends StatefulWidget {
  Function(String) selectedValueChange;
  String? selectedValue;
  String? title;
  List<Map<String, String?>> optionList;
  double? width;
  CategoryDropdownWidgetDesktop({
    Key? key,
    required this.selectedValueChange,
    this.selectedValue = "",
    required this.title,
    required this.optionList,
    this.width = 377,
  }) : super(key: key);

  @override
  State<CategoryDropdownWidgetDesktop> createState() => _CategoryDropdownWidgetDesktopState();
}

class _CategoryDropdownWidgetDesktopState extends State<CategoryDropdownWidgetDesktop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title!,
          style: TextStyle(
              fontSize: 16,
              fontFamily: Strings.fontIranSans,
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
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
                  .map((e) => DropdownMenuItem<String>(
                        value: e['title']!,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              e['title']!,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                                width: 20,
                                height: 25,
                                child: Image.asset(e['image']!)),
                          ],
                        ),
                      ))
                  .toList(),
              //  [
              //   DropdownMenuItem<String>(
              //     value: 'فیزیکی',
              //     child: Row(
              //       children: [
              //         Container(
              //             width: 20,
              //             height: 25,
              //             child: Image.asset(Assets.hourglass)),
              //         Text(
              //           'فیزیکی',
              //           textDirection: TextDirection.rtl,
              //           style: const TextStyle(
              //             fontSize: 14,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              //   DropdownMenuItem<String>(
              //     value: 'دیجیتال',
              //     child: Row(
              //       children: [
              //         Container(
              //             width: 20,
              //             height: 25,
              //             child: Image.asset(Assets.hourglass)),
              //         Text(
              //           'دیجیتال',
              //           textDirection: TextDirection.rtl,
              //           style: const TextStyle(
              //             fontSize: 14,
              //           ),
              //         )
              //       ],
              //     ),
              //   )
              // ],
              validator: (value) {
                if (value == null) {
                  return 'نوع جلد را انتخاب کنید...';
                }
                return null;
              },
              onChanged: (value) {
                widget.selectedValueChange
                    .call(MapCategories.returnNumber((value.toString())));
              },
              onSaved: (value) {
                widget.selectedValue = value.toString();
              },
              buttonStyleData: ButtonStyleData(
                  height: 60,
                  padding: const EdgeInsets.only(left: 20, right: 10),
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

  DropdownMenuItem<String> getDropdownItem() {
    return DropdownMenuItem<String>(
      value: 'دیجیتال',
      child: Row(
        children: [
          SizedBox(
              width: 20, height: 25, child: Image.asset(Assets.hourglass)),
          const Text(
            'دیجیتال',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
