import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';

class DefaultOutlinedButton extends StatefulWidget {
  final Color ContainerColor;

  final String text;

  final Function pressed;
  final bool loading;
  final Widget? leftIcon;
  final double width;
  final double raduis;
  TextStyle? textStyle;

  DefaultOutlinedButton({
    super.key,
    this.ContainerColor = AppColors.primary,
    required this.text,
    required this.pressed,
    this.textStyle,
    this.loading = false,
    this.width = double.infinity,
    this.raduis = 100,
    this.leftIcon,
  });

  @override
  State<DefaultOutlinedButton> createState() => _DefaultOutlinedButtonState();
}

class _DefaultOutlinedButtonState extends State<DefaultOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
      child: InkWell(
          onTap: () {
            widget.pressed();
          },
          child: Center(
            child: widget.loading
                ? const CircularProgressIndicator(
                    color: AppColors.primary,
                  )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.text,
                          style: widget.textStyle ??
                              AppTextStyle.semiBoldSecondary14),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: widget.leftIcon,
                      )
                    ],
                  ),
          )),
    );
  }
}
