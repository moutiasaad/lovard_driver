import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/colors.dart';
import '../../view/login/login_layout.dart';
import '../components/text/CText.dart';
import '../local/cash_helper.dart';
import '../local/secure_cash_helper.dart';

Widget noFavoriteProduct({
  required BuildContext context,
  required Function pressed,
}) =>
    SizedBox(
      width: 327,
      height: 350,
      child: Stack(
        children: [
          Image.asset(
            AppImages.noFavoriteProduct,
            fit: BoxFit.cover,
            height: 276,
            width: 327,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                cText(
                    text: context
                        .translate('errorsMessage.noFavoriteProductTitle'),
                    style: AppTextStyle.semiBoldBlack18),
                cText(
                  text:
                      context.translate('errorsMessage.noFavoriteProductDesc'),
                  style: AppTextStyle.regularBlack2_14,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      pressed();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 4),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.secondary, width: 1))),
                      child: Text(
                        context.translate('buttons.seeProducts'),
                        style: AppTextStyle.semiBoldSecondary14,
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );

Widget noOrders({
  required BuildContext context,
}) =>
    Container(
      width: 327,
      height: 280,
      margin: const EdgeInsets.only(bottom: 120),
      child: Stack(
        children: [
          Image.asset(
            AppImages.noOrders,
            fit: BoxFit.cover,
            height: 276,
            width: 327,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                cText(
                    text: context.translate('errorsMessage.noOrdersTitle'),
                    style: AppTextStyle.semiBoldBlack18),
                cText(
                  text: context.translate('errorsMessage.noOrdersDesc'),
                  style: AppTextStyle.regularBlack2_14,
                ),
              ],
            ),
          ),
        ],
      ),
    );




Widget undefinedError({
  required BuildContext context,
}) =>
    Container(
      width: 327,
      height: 280,
      margin: const EdgeInsets.only(bottom: 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.paymentError,
            fit: BoxFit.cover,
            height: 120,
            width: 140,
          ),
          Column(
            children: [
              cText(
                  text: context.translate('errorsMessage.undefinedError'),
                  style: AppTextStyle.semiBoldBlack18),
              cText(
                text: context.translate('errorsMessage.undefinedErrorDesc'),
                style: AppTextStyle.regularBlack2_14,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
              onTap: () async {
                await CashHelper.clearData();
                await SecureCashHelper.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginLayout(),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 4),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.secondary, width: 1))),
                child: Text(
                  'إعادة التسجيل',
                  style: AppTextStyle.semiBoldSecondary14,
                ),
              ))
        ],
      ),
    );


Widget noCategorie({
  required BuildContext context,
}) =>
    Container(
      width: 327,
      height: 280,
      margin: const EdgeInsets.only(bottom: 120),
      child: Stack(
        children: [
          Image.asset(
            AppImages.noOrders,
            fit: BoxFit.cover,
            height: 276,
            width: 327,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                cText(
                    text: "لا يوجد منتجات متاحة لهذه الفئة",
                    style: AppTextStyle.semiBoldBlack18),
                cText(
                  text: 'إذا تم إضافة أي منتجات جديدة سوف تجدها هنا',
                  style: AppTextStyle.regularBlack2_14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
