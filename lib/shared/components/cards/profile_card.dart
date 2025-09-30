import 'package:flutter/material.dart';

import 'package:lovard_delivery_app/shared/language/extension.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';
import '../image/svg_icon.dart';
import '../text/CText.dart';

class ProfileOptionCard extends StatelessWidget {
  final String text;
  final String icon;
  final Function pressed;
  final bool withForword;

  const ProfileOptionCard(
      {super.key,
      required this.text,
      required this.icon,
      required this.pressed,
      this.withForword = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: MaterialButton(
        onPressed: () {
          pressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon: icon,
              height: 22,
              width: 22,

            ),
            const SizedBox(
              width: 16,
            ),
            cText(
                text: context.translate(text),
                style: AppTextStyle.mediumBlack14),
            const Spacer(),
            Visibility(
              visible: withForword,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: BorderColor.grey,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
