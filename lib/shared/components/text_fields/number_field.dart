
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';




class NumberField extends StatefulWidget {
  const NumberField(
      {super.key,
      required this.label,
      required this.controller,
      required this.onChange,
      required this.validate});

  final String label;
  final TextEditingController controller;
  final Function validate;
  final Function onChange;

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            maxLines: 1,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            scrollPadding: EdgeInsets.zero,
            cursorHeight: 20,
            keyboardType: TextInputType.number,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            validator: (value) {
              return widget.validate(value);
            },
            onChanged: (value) {
              widget.onChange(value);
            },
            style: AppTextStyle.regularPrimary14,
            cursorColor: TextColor.primary,
            decoration: InputDecoration(
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
                borderSide:
                    const BorderSide(color: BorderColor.black2, width: 1.0),
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
            ),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 89,
                height: 57,
                decoration: BoxDecoration(
                  color: BackgroundColor.white100,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: BorderColor.grey,
                    width: 1,
                  ),
                ),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   enableDrag: false,
                    //   backgroundColor: Colors.black.withOpacity(0.5),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(16.0),
                    //       topRight: Radius.circular(16.0),
                    //     ),
                    //   ),
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return FractionallySizedBox(
                    //         heightFactor: 0.7,
                    //         child: BottomSheetNumberList());
                    //   },
                    // ).then((value) {
                    //   setState(() {
                    //     widget.data.phoneNumberCode = value[0];
                    //     widget.data.country = value[1];
                    //     widget.data.CountryId = value[2];
                    //   });
                    //
                    //   print(value[0]);
                    //   print(value[1]);
                    // });
                  },
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CountryFlag.fromCountryCode(
                          'sa',
                          height: 22,
                          width: 28,
                          shape: const RoundedRectangle(3),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '+966',
                          style: AppTextStyle.regularPrimary14,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
