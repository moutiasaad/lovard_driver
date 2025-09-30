import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/components/text/CText.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:lovard_delivery_app/utils/app_text_styles.dart';
import 'package:lovard_delivery_app/utils/colors.dart';

class HomeSegmant extends StatefulWidget {
   HomeSegmant({super.key, required this.onPress,required this.selected});
  int selected;
  final Function onPress;

  @override
  State<HomeSegmant> createState() => _HomeSegmantState();
}

class _HomeSegmantState extends State<HomeSegmant> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: BorderColor.grey,
              height: 1,
            ),
          ),
          Row(
            spacing: 18,
            children: [
              InkWell(
                onTap: (){
                  widget.onPress(0);
                },
                child: Container(
                  width: 110,
                  child: Column(
                    spacing: 8,
                    children: [
                      cText(text: context.translate("home.allOrder"),
                          style: widget.selected == 0 ?
                          AppTextStyle.mediumPrimary16 :AppTextStyle.mediumBlack1_16),
                      Container(
                        color: BorderColor.primary,
                        height:widget.selected == 0 ? 2 : 0,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  widget.onPress(1);
                },
                child: Container(
                  width: 110,
                  child: Column(
                    spacing: 8,
                    children: [
                      cText(text: context.translate("home.orderToYou"),
                    style: widget.selected == 1 ?
                    AppTextStyle.mediumPrimary16 :AppTextStyle.mediumBlack1_16),
                      Container(
                        color: BorderColor.primary,
                        height:widget.selected == 1 ? 2 : 0,
                      )
                    ],
                  ),
                ),
              ),
            ],

          ),

        ],
      ),
    );
  }
}
