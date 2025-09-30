import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/app_text_styles.dart';
import '../buttons/cancel_button.dart';

AppBar designSheetAppBar({
  required String text,
  required BuildContext context,
  Function? cancel,
  IconData icon = CupertinoIcons.xmark,
  bool isCentred = true,
  bool isLeading = true,
  TextStyle? style,
}) =>
    AppBar(
      toolbarHeight: 56,
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: const Color(0xFFF5F5F5),
      title: Text(text, style: style ?? AppTextStyle.semiBoldPrimary16),
      centerTitle: isCentred,
      leading: isLeading
          ? CancelButton(
              context: context,
              icon: icon,
              cancel: cancel,
            )
          : null,
    );
