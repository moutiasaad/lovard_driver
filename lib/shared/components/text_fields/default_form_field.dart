import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';

class DefaultFormField extends StatefulWidget {
  final TextEditingController contoller;
  final TextInputType type;
  Function? validate;
  Function? onChange;
  final String? label;
  bool suffix;
  Widget? suffixWidget;
  bool isPassword;
  bool? isUpdate;
  String? hint;
  Function? tab;
  int maxLines ;
  final FocusNode? focusNode;

  DefaultFormField(
      {super.key,
      required this.contoller,
      required this.type,
      this.validate,
      this.label,
      this.suffix = false,
      this.onChange,
      this.isUpdate,
      this.isPassword = false,
      this.hint,
      this.maxLines = 1,
        this.tab,
      this.suffixWidget,
        this.focusNode,});

  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  Function? submited;



  Function? suffixPressed;

  IconData? prefix;

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      readOnly: widget.isUpdate == true ? true : false,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      onChanged: (value) {
        widget.onChange!(value);
      },
      maxLines: widget.maxLines,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      scrollPadding: EdgeInsets.zero,
      cursorHeight: 20,
      controller: widget.contoller,
      keyboardType: widget.type,
      validator: (String? value) {
        return widget.validate!(value);
      },
      onTap: () {
        widget.tab!();
      },
      style: AppTextStyle.regularPrimary14,
      cursorColor: TextColor.primary,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: AppTextStyle.regularBlack1_16,
        labelText: widget.label,
        labelStyle: AppTextStyle.regularBlack1_16,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 18, 10, 18),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
            color: BorderColor.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: BorderColor.black2, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
            color: BorderColor.red,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
            color: BorderColor.grey,
            width: 1.0,
          ),
        ),

        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        //   borderSide: BorderSide(
        //     color: redColor,
        //     width: 2.0,
        //   ),
        // ),

        prefixIcon: prefix != null
            ? Icon(
                prefix,
                color: color,
              )
            : null,
        suffixIcon: widget.suffix == true && widget.suffixWidget == null
            ? IconButton(
                icon: Icon(
                  widget.isPassword == true
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.black,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
              )
            : widget.suffixWidget,
      ),
    );
  }
}
