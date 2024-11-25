import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {

  void showSnackBar({required String text,required Color backgroundColor}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }


}
