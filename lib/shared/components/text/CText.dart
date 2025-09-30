import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';

import '../../../utils/app_icons.dart';
import '../../../utils/app_text_styles.dart';
import '../image/svg_icon.dart';

Widget cText({
  required String text,
  required TextStyle style,
  double pTop = 0,
  double pBottom = 0,
  double pRight = 0,
  double pLeft = 0,
  TextAlign? textAlign,
  int? maxLine,
  TextOverflow? overflow,
  bool isPrice = false,
}) =>
    Padding(
      padding: EdgeInsets.only(
        top: pTop,
        bottom: pBottom,
        right: pRight,
        left: pLeft,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [

          Text(
           // '$text ${isPrice ? CashHelper.getCurrency() : ''}',
            '$text',
            overflow: overflow,
            maxLines: maxLine,
            textAlign: textAlign,
            style: style,
          ),
          isPrice ? Padding(
            padding: const EdgeInsets.only(right: 5),
            child: SvgIcon(icon: AppIcons.price, height: style.fontSize!,width: 14,color: style.color,),
          ) : SizedBox(),
        ],
      ),
    );

/// combined TExt

Widget combinedText({
  required String firstText,
  required String secondText,
  required Function pressed,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(firstText, style: AppTextStyle.regularPrimary14),
        SizedBox(
          height: 20,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 5),
            ),
            onPressed: () {
              pressed();
            },
            child: Text(secondText, style: AppTextStyle.mediumSecondary14),
          ),
        ),
      ],
    );

/// verification otp

Widget verificationCodeError({
  required BuildContext context,
  required bool error,
}) =>
    Visibility(
      visible: error,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(context.translate('errorMessages.otpCode'),
            style: AppTextStyle.regularRed14),
      ),
    );
