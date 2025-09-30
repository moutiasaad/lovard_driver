import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';

class DefaultButton extends StatefulWidget {
  final Color ContainerColor;
  final String text;
  final Function pressed;
  final bool loading;
  final bool activated;
  TextStyle? textStyle;
  double height;
  double width;
  Widget? leftWidget;
  double raduis;

  DefaultButton(
      {super.key,
      this.height = 50,
      this.ContainerColor = ButtonColor.disabled,
      this.textStyle,
      required this.text,
      required this.pressed,
      this.loading = false,
      required this.activated,
      this.width = double.infinity,
      this.leftWidget,
      this.raduis = 25});

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.leftWidget != null
          ? const EdgeInsets.symmetric(horizontal: 20)
          : null,
      decoration: BoxDecoration(
        color: widget.activated == true ? AppColors.primary : Colors.black45,
        borderRadius: BorderRadius.circular(widget.raduis),
        boxShadow: [
          BoxShadow(
            color: widget.activated == true
                ? widget.ContainerColor.withOpacity(0.1)
                : const Color(0xffECECEC).withOpacity(0.2),
            spreadRadius: -10,
            blurRadius: 40,
            offset: const Offset(0, 25), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
          onTap: () {
            if (widget.activated == true && widget.loading == false) {
              widget.pressed();
            }
          },
          child: Center(
            child: widget.loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: widget.leftWidget != null
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      Text(widget.text,
                          style: widget.textStyle ?? AppTextStyle.buttonWhite),
                      widget.leftWidget ?? const SizedBox()
                    ],
                  ),
          )),
    );
  }
}
