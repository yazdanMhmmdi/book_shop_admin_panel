import 'dart:io';

import 'package:book_shop_admin_panel/presentation/cubit/book_edit_validation_cubit.dart';
import 'package:book_shop_admin_panel/presentation/widgets/warning_bar/warning_bar_desktop.dart';

import '../../../core/constants/assets.dart';
import '../../../core/params/request_params.dart';
import '../../../core/utils/typogaphy.dart';
import '../../../data/models/book_model.dart';
import '../../../domain/usecases/edit_books_usecase.dart';
import '../../bloc/books_bloc.dart';
import '../category_drowp_down_widget/category_dropdown_widget_desktop.dart';
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
import '../price_text_field_desktop.dart';
import '../warning_bar/warning_bar_mobile.dart';

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

  CurrencyTextInputFormatter _pagesFormatter = CurrencyTextInputFormatter(
    customPattern: customThreeDigitsPattern,
    decimalDigits: 0,
  );
  CurrencyTextInputFormatter _salesFormatter = CurrencyTextInputFormatter(
    customPattern: customThreeDigitsPattern,
    decimalDigits: 0,
  );
  TextEditingController _languageController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _voteCountController = TextEditingController();
  TextEditingController _pageCountController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _priceCountController = TextEditingController();
  TextEditingController _salesCountCountController = TextEditingController();

  BookEditValidationCubit? _bookEditValidationCubit;
  @override
  void initState() {
    super.initState();
    _booksBloc = BlocProvider.of<BooksBloc>(context);
    _bookEditValidationCubit =
        BlocProvider.of<BookEditValidationCubit>(context);
    //notify price formatter
    initListeners();
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  textField("نویسنده", 377, _writerController..text, 50),
                  SizedBox(
                    width: 260,
                    child: BlocBuilder<BookEditValidationCubit,
                        BookEditValidationState>(
                      builder: (context, state) {
                        if (state is ValidationStatus) {
                          return state.bookWriterError!.isNotEmpty
                              ? WarningBarDesktop(text: state.bookWriterError!)
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  textField("موضوع کتاب", 377, _nameController..text, 50),
                  SizedBox(
                    width: 260,
                    child: BlocBuilder<BookEditValidationCubit,
                        BookEditValidationState>(
                      builder: (context, state) {
                        if (state is ValidationStatus) {
                          return state.bookNameError!.isNotEmpty
                              ? WarningBarDesktop(text: state.bookNameError!)
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          multiTextField("توضیحات", _descriptionController..text, 560),
          SizedBox(
            width: 260,
            child:
                BlocBuilder<BookEditValidationCubit, BookEditValidationState>(
              builder: (context, state) {
                if (state is ValidationStatus) {
                  return state.bookDescError!.isNotEmpty
                      ? WarningBarDesktop(text: state.bookDescError!)
                      : Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  textField("زبان  ", 377, _languageController..text, 15),
                  SizedBox(
                    width: 220,
                    child: BlocBuilder<BookEditValidationCubit,
                        BookEditValidationState>(
                      builder: (context, state) {
                        if (state is ValidationStatus) {
                          return state.bookLanguageError!.isNotEmpty
                              ? WarningBarDesktop(
                                  text: state.bookLanguageError!)
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(
                    width: 186,
                    child: BlocBuilder<BookEditValidationCubit,
                        BookEditValidationState>(
                      builder: (context, state) {
                        if (state is ValidationStatus) {
                          return state.bookVoteCountError!.isNotEmpty
                              ? WarningBarDesktop(
                                  text: state.bookVoteCountError!)
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PriceTextFieldDesktop(
                    title: "قیمت",
                    controller: _priceCountController..text,
                    width: 186,
                    maxLengh: 14,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    width: 186,
                    child: BlocBuilder<BookEditValidationCubit,
                        BookEditValidationState>(
                      builder: (context, state) {
                        if (state is ValidationStatus) {
                          return state.bookPriceError!.isNotEmpty
                              ? WarningBarDesktop(text: state.bookPriceError!)
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  textField(
                    "تعداد فروش  ",
                    186,
                    _salesCountCountController..text,
                    11,
                    textInputType: TextInputType.number,
                    threeDigitSeperator: true,
                  ),
                  SizedBox(
                    width: 186,
                    child: BlocBuilder<BookEditValidationCubit,
                        BookEditValidationState>(
                      builder: (context, state) {
                        if (state is ValidationStatus) {
                          return state.bookSalesCountError!.isNotEmpty
                              ? WarningBarDesktop(
                                  text: state.bookSalesCountError!)
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  textField("تعداد صفحات", 186, _pageCountController..text, 6,
                      textInputType: TextInputType.number,
                      threeDigitSeperator: true),
                  SizedBox(
                    width: 186,
                    child: BlocBuilder<BookEditValidationCubit,
                        BookEditValidationState>(
                      builder: (context, state) {
                        if (state is ValidationStatus) {
                          return state.bookPagesCountError!.isNotEmpty
                              ? WarningBarDesktop(
                                  text: state.bookPagesCountError!)
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
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
              CategoryDropdownWidgetDesktop(
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
                  if (_bookEditValidationCubit!.bookNameError!.isEmpty &&
                      _bookEditValidationCubit!.bookWroterError!.isEmpty &&
                      _bookEditValidationCubit!.bookPriceError!.isEmpty &&
                      _bookEditValidationCubit!.bookSalesCountError!.isEmpty &&
                      _bookEditValidationCubit!.bookVoteCountError!.isEmpty &&
                      _bookEditValidationCubit!.bookDescError!.isEmpty &&
                      _bookEditValidationCubit!.bookLanguageError!.isEmpty &&
                      _bookEditValidationCubit!.bookPagesCountError!.isEmpty) {
                    _booksBloc!.add(AddEvent(
                        pictureFile: GlobalClass.file,
                        categoryId: _categoryTypeId,
                        coverType: _coverType,
                        description: _descriptionController.text,
                        language: _languageController.text,
                        name: _nameController.text,
                        pagesCount:
                            _pagesFormatter.getUnformattedValue().toString(),
                        voteCount: _voteCountController.text,
                        price: _formatter.getUnformattedValue().toString(),
                        salesCount:
                            _salesFormatter.getUnformattedValue().toString(),
                        writer: _writerController.text));
                    setState(() {
                      GlobalClass.file = File(Assets.bookPlaceHolder);
                    });
                    Navigator.pop(context);
                  }
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
    String title,
    double width,
    TextEditingController controller,
    maxLengh, {
    Function(String)? onChanged,
    TextInputType? textInputType,
    bool? isOnlyDigit,
    bool threeDigitSeperator = false,
  }) {
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
                  threeDigitSeperator
                      ? CurrencyTextInputFormatter(
                          customPattern: customThreeDigitsPattern,
                          decimalDigits: 0,
                        )
                      : FilteringTextInputFormatter.singleLineFormatter,
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

  void initListeners() {
    _nameController.addListener(() {
      _bookEditValidationCubit!.bookNameValidation(_nameController.text);
    });
    _writerController.addListener(() {
      _bookEditValidationCubit!.bookWriterValidation(_writerController.text);
    });
    _descriptionController.addListener(() {
      _bookEditValidationCubit!.bookDescValidation(_descriptionController.text);
    });
    _languageController.addListener(() {
      _bookEditValidationCubit!
          .bookLanguageValidation(_languageController.text);
    });
    _pageCountController.addListener(() {
      _pagesFormatter.format(_pageCountController.text);
      _bookEditValidationCubit!.bookPagesCountValidation(
          _pagesFormatter.getUnformattedValue().toString());
    });
    _salesCountCountController.addListener(() {
      _salesFormatter.format(_salesCountCountController.text);
      _bookEditValidationCubit!.bookSalesValidation(
          _salesFormatter.getUnformattedValue().toString());
    });
    _voteCountController.addListener(() {
      _bookEditValidationCubit!.bookVotesValidation(_voteCountController.text);
    });

    _priceCountController.addListener(() {
      _formatter.format(_priceCountController.text);
      _bookEditValidationCubit!.bookPriceValidation(_priceCountController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
