import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:provider/provider.dart';
import '../../../shared/components/buttons/cancel_button.dart';
import '../../../shared/components/buttons/default_button.dart';
import '../../../shared/components/text_fields/default_form_field.dart';
import '../../../shared/components/text_fields/number_field.dart';
import '../../../shared/logique_function/validater.dart';
import '../../models/static_model/user_model.dart';
import '../../providers/register_provider.dart';
import '../../shared/components/text/CText.dart';
import '../../shared/local/cash_helper.dart';
import '../../utils/app_text_styles.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key});

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  TextEditingController fullNameController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  late UserModel user;

  @override
  void initState() {
    user = CashHelper.getUserData();

    setState(() {
      fullNameController.text = user.fullName ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
        builder: (context, registerProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: cText(
                text: 'الاسم',
                style: AppTextStyle.semiBoldPrimary20),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: CancelButton(
              context: context,
              icon: Icons.arrow_back,
              cancel: () {
                Navigator.pop(context);
              },
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                DefaultFormField(
                    contoller: fullNameController,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return context.translate('errorsMessage.nameEmpty');
                      }
                    },
                    type: TextInputType.text,
                    label: context.translate('login.fullName'))
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: DefaultButton(
              loading: registerProvider.loading,
              text: context.translate('buttons.save'),
              pressed: () {
                if (formKey.currentState!.validate()) {
                  registerProvider.updateFullName(
                    context: context,
                    fullName: fullNameController.text,
                  );
                } else {
                  return;
                }
              },
              activated: true),
        ),
      );
    });
  }
}
