import 'package:flutter/material.dart';


import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';

class SelectButton extends StatefulWidget {
  final Color ContainerColor;

  final String text;

  final Function pressed;
  final bool loading;

  final double width;
  final double raduis;

  const SelectButton({
    super.key,
    this.ContainerColor = AppColors.secondary,
    required this.text,
    required this.pressed,
    this.loading = false,
    this.width = double.infinity,
    this.raduis = 100,
  });

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.raduis),
        border: Border.all(
          color: widget.ContainerColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.ContainerColor.withOpacity(0.1),
            spreadRadius: -10,
            blurRadius: 40,
            offset: const Offset(0, 25), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          widget.pressed();
        },
        child: widget.loading
            ? const CircularProgressIndicator(
                color: AppColors.secondary,
              )
            : Text(
                widget.text,
                style: AppTextStyle.semiBoldSecondary14,
              ),
      ),
    );
  }
}
