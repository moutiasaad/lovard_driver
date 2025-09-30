import 'package:flutter/cupertino.dart';


import '../../../utils/app_text_styles.dart';
import '../text/CText.dart';

Widget driverHeader({
  required String text,
  required BuildContext context,
  Function? cancel,
  IconData icon = CupertinoIcons.xmark,
  bool isCentred = false,
  bool isLeading = false,
  bool elevation = false,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Row(
        children: [
          cText(
            text: text,
            style: AppTextStyle.semiBoldBlack22,
          ),
        ],
      ),
    );

// AppBar(
// backgroundColor: Colors.white,
// elevation: elevation ? 1 : 0,
// shadowColor: Color(0xFFF5F5F5),
// title: Text(
// text,
// style: AppTextStyle.semiBoldBlack22,
// ),
// centerTitle: isCentred,
// leading: isLeading ? CancelButton(
// context: context,
// icon: icon,
// ) : null,
// ),
