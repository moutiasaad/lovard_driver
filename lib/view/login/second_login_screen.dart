import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';

import 'package:provider/provider.dart';

import '../../../providers/register_provider.dart';
import '../../../shared/components/text/verification_time_text.dart';

import '../../models/register_model.dart';
import '../../shared/components/text/CText.dart';
import '../../shared/components/text_fields/verification_field.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/colors.dart';

class SecondLoginScreen extends StatefulWidget {
  const SecondLoginScreen(
      {super.key, required this.data, required this.forword});

  final RegisterModel data;
  final Function forword;

  @override
  State<SecondLoginScreen> createState() => _SecondLoginScreenState();
}

class _SecondLoginScreenState extends State<SecondLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      backgroundColor: BackgroundColor.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cText(
                text: context.translate('login.checkNumber'),
                style: AppTextStyle.boldPrimary22,
                pBottom: 5),
            cText(
                text:
                    '${context.translate('login.codeSendIt')} ${widget.data.phoneNumber}',
                style: AppTextStyle.regularBlack1_16,
                pBottom: 30),
            VerificationField(
              forword: widget.forword,
              clear: () {
                registerProvider.otpError = false;
              },
              //code: 123456,
              secondsRemaining: 60,
              data: widget.data,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: CountdownTimer(
          done: () {},
          secondsRemaining: 20,
        ),
      ),
    );
  }
}
