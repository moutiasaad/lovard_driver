import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../utils/colors.dart';

Widget CancelButton({
  required BuildContext context,
  Function? cancel,
  IconData icon = CupertinoIcons.xmark,
  Color color = IconColors.primary,
  double size = 18,
}) =>
    SizedBox(
      height: 20,
      width: 20,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          if (cancel != null) {
            cancel();
          } else {
            Navigator.pop(context);
          }
        },
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
