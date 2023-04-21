import 'dart:io';

import '../../../core/params/request_params.dart';
import '../../../data/models/book_model.dart';
import '../../../domain/usecases/edit_books_usecase.dart';
import '../../bloc/books_bloc.dart';
import '../custom_dropdown_widget.dart';
import '../global_class.dart';
import '../price_text_field.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../injector.dart';
import '../category_dropdown_widget.dart';
import '../image_picker_widget.dart';

class EditBookDialog extends StatefulWidget {
  BookModel? bookModel;
  EditBookDialog({required this.bookModel});
  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  BooksBloc? _booksBloc;

  static File? file = File('');

  String? name;

  String? writer;

  String? description;

  String? language;

  String? coverType;

  String? pageCount;

  String? vote;
  CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    customPattern: customCurrencyPattern,
    decimalDigits: 0,
  );
  TextEditingController _nameController = TextEditingController();
  TextEditingController _writerController = TextEditingController();
  String? _coverType;
  String? _categoryTypeId;
  String? _price;
  TextEditingController _languageController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _voteCountController = TextEditingController();
  TextEditingController _pageCountController = TextEditingController();
  TextEditingController _priceCountController = TextEditingController();
  TextEditingController _salesCountCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initDialog();
    //notify price formatter
    _priceCountController.addListener(() {
      _formatter.format(_priceCountController.text);
    });
    // _booksBloc!.add(ReturnSelectedBookEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(38),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, -1),
                blurRadius: 4,
                spreadRadius: 0,
                color: IColors.black15,
              ),
            ]),
        child: objects());
  }

  Widget objects() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              textField("نویسنده", 377,
                  _writerController..text = "${widget.bookModel!.writer!}", 50),
              SizedBox(width: 16),
              textField("موضوع کتاب", 377,
                  _nameController..text = "${widget.bookModel!.name!}", 50)
            ],
          ),
          SizedBox(height: 16),
          multiTextField(
              "توضیحات",
              _descriptionController
                ..text = "${widget.bookModel!.description!}",
              560),
          SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              // textField(
              //     "نوع جلد",
              //     377,
              //     _coverTypeController
              //       ..text = "${widget.bookModel!.coverType!}",
              //     10),
              CustomDropdownWidget(
                title: "نوع جلد",
                optionList: const ['دیجیتال', 'فیزیکی'],
                selectedValue: widget.bookModel!.coverType,
                selectedValueChange: (val) {
                  _coverType = val;
                },
              ),

              SizedBox(width: 16),
              textField(
                  "زبان  ",
                  377,
                  _languageController..text = "${widget.bookModel!.language!}",
                  15),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              textField(
                  "رای  ",
                  186,
                  _voteCountController
                    ..text = "${widget.bookModel!.voteCount!}",
                  3,
                  textInputType: TextInputType.number,
                  isOnlyDigit: true, onChanged: (val) {
                if (val.isNotEmpty) {
                  if (double.parse(val) >= 5.0) {
                    _voteCountController.text = "5";
                  }
                }
              }),
              const SizedBox(width: 8),
              PriceTextField(
                title: "قیمت",
                controller: _priceCountController
                  ..text = _formatter.format(widget.bookModel!.price!),
                width: 186,
                maxLengh: 14,
                textInputType: TextInputType.number,
              ),
              const SizedBox(width: 8),
              textField(
                  "تعداد فروش  ",
                  186,
                  _salesCountCountController
                    ..text = "${widget.bookModel!.salesCount!}",
                  3,
                  textInputType: TextInputType.number,
                  isOnlyDigit: true),
              const SizedBox(width: 8),
              textField(
                "تعداد صفحات",
                186,
                _pageCountController..text = "${widget.bookModel!.pagesCount!}",
                4,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ImagePickerWidget(
                imgUrl: widget.bookModel!.picture!,
                onFilePicked: (file) {
                  GlobalClass.file = file;
                },
              ),
              const SizedBox(
                width: 16,
              ),
              CategoryDropdownWidget(
                selectedValue: _mapCategoriesFromId(_categoryTypeId!),
                title: "دسته بندی",
                optionList: categoryList,
                selectedValueChange: (val) {
                  _categoryTypeId = val;
                },
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            ".اگر عکسی انتخاب نکنید عکس قبلی به عنوان پیش فرض قرار خواهد گرفت",
            style: TextStyle(
                color: IColors.black35,
                fontSize: 14,
                fontFamily: Strings.fontIranSans,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 38,
            width: 770,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.boldGreen,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black26,
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  _booksBloc!.add(EditEvent(
                      pictureFile: GlobalClass.file,
                      bookId: widget.bookModel!.id,
                      coverType: _coverType,
                      description: _descriptionController.text,
                      language: _languageController.text,
                      name: _nameController.text,
                      categoryId: _categoryTypeId,
                      pagesCount: _pageCountController.text,
                      voteCount: _voteCountController.text,
                      price: _formatter.getUnformattedValue().toString(),
                      salesCount: _salesCountCountController.text,
                      writer: _writerController.text));
                  // EditBookUsecase usecase = EditBookUsecase(sl());
                  // var s = await usecase(EditBookRequestParams(
                  //     pictureFile: GlobalClass.file,
                  //     bookId: widget.bookModel!.id,
                  //     coverType: widget.bookModel!.coverType,
                  //     description: widget.bookModel!.description,
                  //     language: widget.bookModel!.language,
                  //     name: widget.bookModel!.name,
                  //     pagesCount: widget.bookModel!.pagesCount,
                  //     voteCount: widget.bookModel!.voteCount.toString(),
                  //     writer: widget.bookModel!.writer));
                  setState(() {
                    GlobalClass.file = File('');
                  });
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    "ویرایش کتاب",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: Strings.fontIranSans,
                        fontSize: 16,
                        color: Colors.white70,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textField(
      String title, double width, TextEditingController controller, maxLengh,
      {Function(String)? onChanged,
      TextInputType? textInputType,
      bool? isOnlyDigit}) {
    onChanged ??= onChanged = (v) {
      return '';
    };
    textInputType ??= TextInputType.text;
    isOnlyDigit ??= false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
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
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                  child: TextField(
                controller: controller,
                onChanged: onChanged,
                maxLines: 1,
                keyboardType: textInputType,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(maxLengh),
                  isOnlyDigit
                      ? FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]+\.?[0-9]*'))
                      : FilteringTextInputFormatter.singleLineFormatter,
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

  Widget multiTextField(
      String title, TextEditingController controller, int maxLengh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
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
          color: Colors.transparent,
          child: Container(
            height: 92,
            width: 770,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  maxLines: 3,
                  controller: controller,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(maxLengh),
                  ],
                  style: const TextStyle(
                      fontFamily: Strings.fontIranSans, fontSize: 16),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          bottom: 8, right: 16, left: 16, top: 11)),
                )),
          ),
        ),
      ],
    );
  }

  initDialog() {
    _booksBloc = BlocProvider.of<BooksBloc>(context);
    _coverType = widget.bookModel!.coverType;
    _categoryTypeId = widget.bookModel!.categoryId!;
  }

  String _mapCategoriesFromId(String value) {
    switch (value) {
      case "1":
        return Strings.categoryOptionSicence;

      case '2':
        return Strings.categoryOptionMedicine;

      case '3':
        return Strings.categoryOptionHistory;

      case '4':
        return Strings.categoryOptionJudiciary;

      case '5':
        return Strings.categoryOptionFoods;
      default:
        return Strings.categoryOptionSicence;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
