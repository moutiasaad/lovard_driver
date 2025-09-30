import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/models/transaction_model.dart';
import 'package:lovard_delivery_app/shared/logique_function/time_function.dart';

import '../../../shared/components/image/svg_icon.dart';
import '../../../shared/components/text/CText.dart';
import '../../../shared/logique_function/date_functions.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';

class TransactionCard extends StatefulWidget {
  TransactionCard({super.key, required this.transaction});

  TrModel transaction;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: BackgroundColor.background,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.transaction.type == 'withdrawal'
                  ? ErrorColor.error
                  : ErrorColor.success,
            ),
            child: Image.asset(widget.transaction.type == 'withdrawal'
                ? AppIcons.withdraw
                : AppIcons.deposit),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cText(
                    text: widget.transaction.desc!,
                    style: AppTextStyle.semiBoldBlack14),
                cText(
                    text: '${convertToArabicDate(widget.transaction.date!)} - ${getTimeFromDate(widget.transaction.date!)}',
                    style: AppTextStyle.regularBlack4_14)
              ],
            ),
          ),
          cText(
              text: widget.transaction.amount!,
              style: widget.transaction.type == 'withdrawal'
                  ? AppTextStyle.mediumRed12
                  : AppTextStyle.mediumGreen12)
        ],
      ),
    );
  }
}
