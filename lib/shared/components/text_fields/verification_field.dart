import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/register_model.dart';
import '../../../providers/register_provider.dart';
import '../../../utils/colors.dart';
import '../text/CText.dart';

class VerificationField extends StatefulWidget {
  const VerificationField({
    super.key,
    required this.secondsRemaining,
    required this.data,
    required this.forword,
    required this.clear,
  });

  final int secondsRemaining;
  final RegisterModel data;
  final Function forword;
  final Function clear;

  @override
  _VerificationFieldState createState() => _VerificationFieldState();
}

class _VerificationFieldState extends State<VerificationField> {
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    widget.clear();
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Normal single input field for code
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            enabled: widget.secondsRemaining != 0,
            textAlign: TextAlign.start, // normal left text position
            decoration: InputDecoration(
              labelText: "أدخل رمز التحقق", // Arabic: Enter verification code
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: registerProvider.isOtpError == false
                      ? BorderColor.grey
                      : BorderColor.red,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: registerProvider.isOtpError == false
                      ? BorderColor.secondary
                      : BorderColor.red,
                  width: 1.0,
                ),
              ),
              errorText: registerProvider.isOtpError
                  ? "رمز التحقق غير صحيح"
                  : null, // Arabic: Incorrect verification code
            ),
            onChanged: (value) {
              // Reset error when user types
              if (registerProvider.isOtpError) {
                registerProvider.otpError = false;
              }

              // Automatically validate when 6 digits are entered
              if (value.length == 6) {
                validateCode(registerProvider);
              }
            },
            onTap: () {
              setState(() {
                registerProvider.otpError = false;
              });
            },
          ),

          const SizedBox(height: 8),

          // Error message below field
          verificationCodeError(
            error: registerProvider.isOtpError,
            context: context,
          ),
        ],
      ),
    );
  }

  void validateCode(RegisterProvider registerProvider) {
    final String enteredCode = codeController.text.trim();

    if (enteredCode.isEmpty || enteredCode.length != 6) {
      setState(() {
        registerProvider.otpError = true;
      });
      return;
    }

    try {
      final int result = int.parse(enteredCode);
      registerProvider.verifierOtp(
        widget.data,
        context,
        widget.forword,
        result,
      );
    } catch (e) {
      setState(() {
        registerProvider.otpError = true;
      });
    }
  }
}
