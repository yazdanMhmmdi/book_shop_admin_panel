// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, must_be_immutable

import 'dart:io';

import '../../cubit/book_edit_validation_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/book_model.dart';
import '../../bloc/books_bloc.dart';
import '../category_drowp_down_widget/category_dropdown_widget_desktop.dart';
import '../custom_dropdown_widget.dart';
import '../global_class.dart';
import '../image_picker_widget.dart';
import '../price_text_field_desktop.dart';
import '../warning_bar/warning_bar_desktop.dart';

class EditBookDialog extends StatefulWidget {
  BookModel? bookModel;
  EditBookDialog({required this.bookModel});
  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  BooksBloc? _booksBloc;


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
  TextEditingController _languageController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _voteCountController = TextEditingController();
  TextEditingController _pageCountController = TextEditingController();
  TextEditingController _priceCountController = TextEditingController();
  TextEditingController _salesCountCountController = TextEditingController();
  CurrencyTextInputFormatter _pagesFormatter = CurrencyTextInputFormatter(
    customPattern: customThreeDigitsPattern,
    decimalDigits: 0,
  );
  CurrencyTextInputFormatter _salesFormatter = CurrencyTextInputFormatter(
    customPattern: customThreeDigitsPattern,
    decimalDigits: 0,
  );
  BookEditValidationCubit? _bookEditValidationCubit;
  @override
  void initState() {
    super.initState();
    initDialog();
    initListeners();
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
                  textField("نویسنده", 377,
                      _writerController..text = widget.bookModel!.writer!, 50),
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
                  textField("موضوع کتاب", 377,
                      _nameController..text = widget.bookModel!.name!, 50),
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
          multiTextField(
              "توضیحات",
              _descriptionController
                ..text = "${widget.bookModel!.description!}",
              560),
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

              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  textField(
                      "زبان  ",
                      377,
                      _languageController..text = widget.bookModel!.language!,
                      15),
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
                  textField(
                      "رای  ",
                      186,
                      _voteCountController
                        ..text = widget.bookModel!.voteCount.toString(),
                      3,
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
                    controller: _priceCountController
                      ..text = _formatter.format(widget.bookModel!.price!),
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
                    _salesCountCountController
                      ..text =
                          _salesFormatter.format(widget.bookModel!.salesCount!),
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
                  textField(
                    "تعداد صفحات",
                    186,
                    _pageCountController
                      ..text =
                          _pagesFormatter.format(widget.bookModel!.pagesCount!),
                    6,
                    textInputType: TextInputType.number,
                    threeDigitSeperator: true,
                  ),
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
                imgUrl: widget.bookModel!.picture!,
                onFilePicked: (file) {
                  GlobalClass.file = file;
                },
              ),
              const SizedBox(
                width: 16,
              ),
              CategoryDropdownWidgetDesktop(
                selectedValue: _mapCategoriesFromId(_categoryTypeId!),
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
            ".اگر عکسی انتخاب نکنید عکس قبلی به عنوان پیش فرض قرار خواهد گرفت",
            style: TextStyle(
                color: IColors.black35,
                fontSize: 14,
                fontFamily: Strings.fontIranSans,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
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
                    _booksBloc!.add(EditEvent(
                      pictureFile: GlobalClass.file,
                      bookId: widget.bookModel!.id,
                      coverType: _coverType,
                      description: _descriptionController.text,
                      language: _languageController.text,
                      name: _nameController.text,
                      categoryId: _categoryTypeId,
                      pagesCount:
                          _pagesFormatter.getUnformattedValue().toString(),
                      voteCount: _voteCountController.text,
                      price: _formatter.getUnformattedValue().toString(),
                      salesCount:
                          _salesFormatter.getUnformattedValue().toString(),
                      writer: _writerController.text,
                      isMobile: false,
                    ));
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
                      GlobalClass.file = File(Assets.bookPlaceHolder);
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Center(
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
          " $title",
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
                          bottom: 8, right: 16, left: 16, top: 11)),
                )),
          ),
        ),
      ],
    );
  }

  initDialog() {
    _booksBloc = BlocProvider.of<BooksBloc>(context);
    _bookEditValidationCubit =
        BlocProvider.of<BookEditValidationCubit>(context);
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
      //notify price formatter
      _formatter.format(_priceCountController.text);
      _bookEditValidationCubit!.bookPriceValidation(_priceCountController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
