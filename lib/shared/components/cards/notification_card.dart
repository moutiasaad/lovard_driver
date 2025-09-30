import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/models/notification_model.dart';
import 'package:lovard_delivery_app/shared/logique_function/date_functions.dart';

import '../../../utils/app_icons.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';
import '../image/svg_icon.dart';
import '../text/CText.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationModel notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        // setState(() {
        //   if (!widget.isRead) {
        //     setState(() {
        //       widget.isRead = true;
        //     });
        //   } else {
        //     return;
        //   }
        // });
      },
      child: Container(
        width: double.infinity,
        color:
            BackgroundColor.background,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.notification.type == 'orders' ?
                  AppColors.primary:AppColors.secondary,
                ),
                child:  SvgIcon(icon:
                widget.notification.type == 'orders' ?
                AppIcons.notificationType1 : AppIcons.notificationType2)),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cText(
                      text: widget.notification.title??'',
                      style: AppTextStyle.semiBoldBlack14),
                  cText(
                      text: widget.notification.body??'',
                      style: AppTextStyle.regularBlack4_14)
                ],
              ),
            ),
            cText(text:widget.notification.date != null ?convertToArabicDate(widget.notification.date!) :'', style: AppTextStyle.regularBlack4_12)
          ],
        ),
      ),
    );
  }
}
