import 'dart:io';

import '../../../core/constants/assets.dart';
import '../../../core/params/request_params.dart';
import '../../../core/utils/typogaphy.dart';
import '../../../data/models/book_model.dart';
import '../../../domain/usecases/edit_books_usecase.dart';
import '../../bloc/books_bloc.dart';
import '../category_dropdown_widget.dart';
import '../global_class.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../injector.dart';
import '../custom_dropdown_widget.dart';
import '../image_picker_widget.dart';
import '../price_text_field.dart';

//base dialog is EditDialog
class AddBookDialog extends StatefulWidget {
  AddBookDialog();
  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<AddBookDialog> {
  BooksBloc? _booksBloc;

  static File? file = File(Assets.bookPlaceHolder);

  String? name;

  String? writer;

  String? description;

  String? language;

  String? coverType;

  String? pageCount;

  String? vote;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _writerController = TextEditingController();
  String? _coverType = Strings.categoryOptionPhyisical;
  String? _categoryTypeId = categoryList[0]['category_id'];
  CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    customPattern: customCurrencyPattern,
    decimalDigits: 0,
  );
  TextEditingController _languageController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _voteCountController = TextEditingController();
  TextEditingController _pageCountController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _priceCountController = TextEditingController();
  TextEditingController _salesCountCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _booksBloc = BlocProvider.of<BooksBloc>(context);
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
                offset: const Offset(1, -1),
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
              textField("نویسنده", 377, _writerController..text, 50),
              const SizedBox(width: 16),
              textField("موضوع کتاب", 377, _nameController..text, 50)
            ],
          ),
          const SizedBox(height: 16),
          multiTextField("توضیحات", _descriptionController..text, 560),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              CustomDropdownWidget(
                  selectedValueChange: (val) {
                    _coverType = val;
                  },
                  title: "نوع جلد",
                  selectedValue: _coverType,
                  optionList: const [
                    Strings.categoryOptionPhyisical,
                    Strings.categoryOptionDigital,
                  ]),
              const SizedBox(width: 16),
              textField("زبان  ", 377, _languageController..text, 15),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              textField("رای  ", 186, _voteCountController..text, 3,
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
                controller: _priceCountController..text,
                width: 186,
                maxLengh: 14,
                textInputType: TextInputType.number,
              ),
              const SizedBox(width: 8),
              textField(
                  "تعداد فروش  ", 186, _salesCountCountController..text, 3,
                  textInputType: TextInputType.number, isOnlyDigit: true),
              const SizedBox(width: 8),
              textField(
                "تعداد صفحات",
                186,
                _pageCountController..text,
                4,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ImagePickerWidget(
                imgUrl: "",
                onFilePicked: (file) {
                  GlobalClass.file = file;
                },
              ),

              const SizedBox(width: 08),
              // textField("شماره دسته بندی  ", 377, _categoryController..text, 6),
              CategoryDropdownWidget(
                selectedValue: Strings.categoryOptionSicence,
                title: "دسته بندی",
                optionList: categoryList,
                selectedValueChange: (val) {
                  _categoryTypeId = val;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
              ".اگر عکسی انتخاب نکنید پیش نمایشی به عنوان عکس پیش فرض قرار خواهد گرفت",
              style: Typogaphy.Regular.copyWith(
                color: IColors.black35,
                fontSize: 14,
                decoration: TextDecoration.none,
              )),
          const SizedBox(
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
                  _booksBloc!.add(AddEvent(
                      pictureFile: GlobalClass.file,
                      categoryId: _categoryTypeId,
                      coverType: _coverType,
                      description: _descriptionController.text,
                      language: _languageController.text,
                      name: _nameController.text,
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
                child: const Center(
                  child: Text(
                    "افزودن کتاب",
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
        const SizedBox(
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
        const SizedBox(
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
                          bottom: 11, right: 16, left: 16, top: 11)),
                )),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
