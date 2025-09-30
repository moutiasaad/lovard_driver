import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/register_provider.dart';

import '../../models/register_model.dart';
import '../../shared/components/buttons/default_button.dart';
import '../../shared/components/text/CText.dart';
import '../../shared/components/text_fields/number_field.dart';

import '../../utils/app_text_styles.dart';
import '../../utils/colors.dart';

class FirstLoginScreen extends StatefulWidget {
  const FirstLoginScreen(
      {super.key, required this.data, required this.forword});

  final RegisterModel data;
  final Function forword;

  @override
  State<FirstLoginScreen> createState() => _FirstLoginScreenState();
}

class _FirstLoginScreenState extends State<FirstLoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  String? phoneError;

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      backgroundColor: BackgroundColor.background,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              cText(
                  text: context.translate('login.welcome'),
                  style: AppTextStyle.boldPrimary22,
                  pBottom: 5),
              cText(
                  text: context.translate('login.enterNumber'),
                  style: AppTextStyle.regularBlack1_16,
                  pBottom: 25),
              NumberField(
                validate: (value) {
                  if (value.toString().isEmpty) {
                    return context.translate('errorsMessage.numberEmpty');
                  } else if (value.toString().length != 9) {
                    return context.translate('errorsMessage.numberContain');
                  } else if (phoneError != null) {
                    return phoneError;
                  }
                  // if (errors.containsKey('phone') &&
                  //     errors['phone'][0] != null) {
                  //   // Key existse
                  //   return errors['phone'][0];
                  // } else {
                  //   return null;
                  // }
                },
                onChange: (value) {},
                label: context.translate('login.phoneNumber'),
                controller: numberController,
              ),
              const SizedBox(
                height: 20,
              ),
              combinedText(
                firstText: context.translate('login.continueAccept'),
                secondText: context.translate('login.privacyPolicy'),
                pressed: () async {
                  final Uri uri =
                      Uri.parse("https://lovard.medlatrous.com/rules.pdf");
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri,
                        mode:
                            LaunchMode.externalApplication); // Open in browser
                  } else {
                    throw 'Could not launch url'; // Error handling
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: DefaultButton(
            loading: registerProvider.loading,
            text: context.translate('buttons.continue'),
            pressed: () {
              phoneError = null;
              print(registerProvider.loading);
              if (registerProvider.loading) {
                return;
              }
              if (formKey.currentState!.validate()) {
                widget.data.phoneNumber = numberController.text;
                registerProvider.register(widget.data, context, widget.forword,
                    (error) {
                  if (error != null) {
                    phoneError = error;
                    formKey.currentState!.validate();
                  }
                });

                // Navigator.push(context, MaterialPageRoute(builder: (context) => SecondLoginScreen(),),);
              }
            },
            activated: true),
      ),
    );
  }
}
