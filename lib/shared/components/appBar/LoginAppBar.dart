import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

Widget loginAppBar({
  required BuildContext context,
  required Function back,
  IconData icon = Icons.arrow_back,

}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              back();
            },
            child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                icon,
                size: 25,
                color: AppColors.primary,
              ),
            ),
          ),
        ),

      ],
    );
