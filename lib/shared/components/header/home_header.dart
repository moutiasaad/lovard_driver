import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';

import '../../../utils/app_images.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';
import '../../local/cash_helper.dart';

import '../text/CText.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Stack(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: GradientColor.homeHeaderGradient,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 180,
                  sigmaY: 180,
                ),
                // Blur effect
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Slight transparency
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 180,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            width: double.infinity,
            // decoration:  BoxDecoration(
            //   gradient: GradientColor.homeHeaderGradient,
            // ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Image.asset(AppImages.homeLogo, width: 40, height: 40, color: AppColors.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cText(
                          text: context.translate('home.welcome') +' '+
                              CashHelper.getUserData().fullName!,
                          style: AppTextStyle.semiBoldBlack18),
                      cText(
                          text: context.translate('home.seeToDayOrder'),
                          style: AppTextStyle.regularBlack14),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
