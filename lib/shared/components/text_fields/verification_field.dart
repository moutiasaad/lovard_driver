import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/register_model.dart';
import '../../../providers/register_provider.dart';
import '../../../utils/colors.dart';
import '../text/CText.dart';

class VerificationField extends StatefulWidget {
  const VerificationField(
      {super.key,
      //required this.code,
      required this.secondsRemaining,
      required this.data,
      required this.forword,
      required this.clear});

  // final int code;
  final int secondsRemaining;
  final RegisterModel data;
  final Function forword;
  final Function clear;

  @override
  _VerificationFieldState createState() => _VerificationFieldState();
}

class _VerificationFieldState extends State<VerificationField> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    widget.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNodes[0]);
    });
    super.initState();
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controllers in controllers) {
      controllers.dispose();
    }
    super.dispose();
  }

  void moveFocusToEmptyField() {
    for (int i = 0; i < controllers.length; i++) {
      if (controllers[i].text.isEmpty) {
        FocusScope.of(context).requestFocus(focusNodes[i]);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              width: 46.0,
              height: 55.0,
              child: TextField(
                  readOnly: widget.secondsRemaining == 0 ? true : false,
                  controller: controllers[index],
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.center,
                  focusNode: focusNodes[index],
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: registerProvider.isOtpError == false
                            ? BorderColor.grey
                            : BorderColor.red,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: registerProvider.isOtpError == false
                            ? BorderColor.secondary
                            : BorderColor.red,
                        width: 1.0,
                      ),
                    ),
                    counterText: '',
                  ),
                  onChanged: (value) {
                    if (value.length == 1 && index < 5) {
                      focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      focusNodes[index - 1].requestFocus();
                    }
                    if (value.length == 1 && index == 5) {
                      validateCode(registerProvider);
                    }
                  },
                  onTap: () {
                    setState(() {
                      registerProvider.otpError = false;
                    });

                    moveFocusToEmptyField();
                  }),
            ),
          ),
        ),
        const SizedBox(
          height: 20 / 2,
        ),
        verificationCodeError(
            error: registerProvider.isOtpError, context: context),
      ],
    ));
  }

  void validateCode(RegisterProvider registerProvider) {
    String combinedValue = '';
    for (TextEditingController i in controllers.reversed) {
      combinedValue += i.text;
    }

    // Combine the values

    int result = int.parse(combinedValue);
    registerProvider.verifierOtp(widget.data, context, widget.forword, result);
  }
}
