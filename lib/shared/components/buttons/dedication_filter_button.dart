import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';
import '../text/CText.dart';

class DedicationFilterButton extends StatefulWidget {
  const DedicationFilterButton(
      {super.key,
      required this.index,
      required this.categoryName,
      required this.press,
      required this.selected});

  final int index;
  final String categoryName;

  final Function press;
  final int selected;

  @override
  State<DedicationFilterButton> createState() => _DedicationFilterButtonState();
}

class _DedicationFilterButtonState extends State<DedicationFilterButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        widget.press();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            width: widget.selected == widget.index ? 2 : 1,
            color: widget.selected == widget.index
                ? AppColors.secondary
                : Colors.grey.withOpacity(0.5),
          )),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10
        ),
        child: Center(
          child: cText(
              text: widget.categoryName,
              style: widget.selected == widget.index
                  ? AppTextStyle.mediumSecondary12
                  : AppTextStyle.mediumPrimary12),
        ),
      ),
    );
  }
}
