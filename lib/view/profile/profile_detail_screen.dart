import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/components/buttons/default_outlined_button.dart';
import 'package:lovard_delivery_app/shared/components/image/svg_icon.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:lovard_delivery_app/utils/app_icons.dart';
import 'package:lovard_delivery_app/utils/colors.dart';
import 'package:lovard_delivery_app/view/profile/update_phone_screen.dart';
import 'package:lovard_delivery_app/view/profile/update_profile_screen.dart';
import 'package:provider/provider.dart';
import '../../../shared/components/buttons/cancel_button.dart';
import '../../../shared/components/buttons/default_button.dart';
import '../../../shared/components/text_fields/default_form_field.dart';
import '../../../shared/components/text_fields/number_field.dart';
import '../../../shared/logique_function/validater.dart';
import '../../models/static_model/user_model.dart';
import '../../providers/register_provider.dart';
import '../../shared/components/text/CText.dart';
import '../../shared/local/cash_helper.dart';
import '../../shared/local/secure_cash_helper.dart';
import '../../utils/app_text_styles.dart';
import '../login/login_layout.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  File profileImage = File('');
  var formKey = GlobalKey<FormState>();
  UserModel? user;

  @override
  void initState() {
    user = CashHelper.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
        builder: (context, registerProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title:
                cText(text: 'بياناتي', style: AppTextStyle.semiBoldPrimary20),
            elevation: 1,
            backgroundColor: Colors.white,
            leading: CancelButton(
              context: context,
              icon: Icons.arrow_back,
              cancel: () {
                Navigator.pop(context);
              },
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateNameScreen(),
                        )).then((value) {
                      user = CashHelper.getUserData();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          cText(
                              text: 'الاسم',
                              style: AppTextStyle.regularBlack1_12),
                          cText(
                              text: user?.fullName ?? '',
                              style: AppTextStyle.mediumBlack14)
                        ],
                      ),
                      SvgIcon(icon: AppIcons.edit)
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: BorderColor.grey1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        cText(
                            text: 'رقم الجوال',
                            style: AppTextStyle.regularBlack1_12),
                        cText(
                            text: user?.phone ?? '',
                            style: AppTextStyle.mediumBlack14)
                      ],
                    ),

                  ],
                ),
                Container(
                  height: 1,
                  color: BorderColor.grey1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 16),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       spacing: 8,
                //       children: [
                //         cText(text: 'البريد الالكتروني', style: AppTextStyle.regularBlack1_12),
                //         cText(text: user?.email??'', style: AppTextStyle.mediumBlack14)
                //       ],
                //     ),
                //     //SvgIcon(icon: AppIcons.orderFill)
                //
                //   ],
                // ),
                // Container(
                //   height: 1,
                //   color: BorderColor.grey1,
                //   width: double.infinity,
                //   margin: EdgeInsets.symmetric(vertical: 16),
                // ),

                InkWell(
                  onTap: () async {
                    showDeleteDialog(context);
                  },
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          cText(
                              text: 'حذف الحساب',
                              style: AppTextStyle.mediumRed14),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (BuildContext contexte) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      height: 300,
                      child: Column(
                        spacing: 12,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: cText(
                                    text:
                                        'هل انت متأكد من رغبتك في حذف الحساب؟',
                                    style: AppTextStyle.semiBoldBlack18),
                              ),
                              CancelButton(
                                size: 25,
                                context: context,
                                icon: CupertinoIcons.xmark,
                                cancel: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                          cText(
                              text:
                                  'سيتم حذف الحساب نهائياً بعد 30 يوم وحذف جميع معلوماتك، خلال هذه المدة يمكنك استرجاع حسابك واستعادة بياناتك',
                              style: AppTextStyle.regularBlack1_14),
                          DefaultButton(
                              raduis: 6,
                              text: 'لا، لا تقم بحذفه',
                              pressed: () async {
                                Navigator.pop(context);
                              },
                              activated: true),
                          DefaultOutlinedButton(
                              ContainerColor: TextColor.red,
                              textStyle: AppTextStyle.mediumRed14,
                              raduis: 6,
                              text: 'نعم، انا متأكد',
                              pressed: () async {
                                await CashHelper.clearData();
                                await SecureCashHelper.clear();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginLayout(),
                                    ));
                              })
                        ],
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
