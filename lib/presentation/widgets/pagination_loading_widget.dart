import 'package:flutter/material.dart';

class PaginationLoadingWidget extends StatelessWidget {
  const PaginationLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
