import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/components/text/CText.dart';
import 'package:lovard_delivery_app/shared/components/text_fields/default_form_field.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:lovard_delivery_app/utils/colors.dart';
import 'package:lovard_delivery_app/view/profile/components/transaction_card.dart';
import 'package:provider/provider.dart';

import '../../providers/wallet_provide.dart';
import '../../shared/components/appBar/design_sheet_app_bar.dart';
import '../../shared/components/buttons/default_button.dart';
import '../../shared/error/error_component.dart';
import '../../utils/app_text_styles.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(builder: (context, walletProvide, child) {
      return Scaffold(
        appBar: designSheetAppBar(
            isLeading: true,
            isCentred: false,
            text: 'المحفضة',
            context: context,
            style: AppTextStyle.semiBoldBlack18),
        backgroundColor: BackgroundColor.background,
        body: FutureBuilder(
            future: walletProvide.getTransactions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.error == 'Failed to load data') {
                return Center(
                  child: noOrders(context: context),
                );
              }

              if (snapshot.hasError) {
                print(snapshot.error);
                if (snapshot.error == 'connection timeout') {
                  return const Center(
                      // child: ConnectionProbleme(
                      //     context: context,
                      //     pressed: () {
                      //       setState(() {
                      //         _refreshData = true;
                      //       });
                      //     }),
                      );
                } else {
                  return Center(child: undefinedError(context: context));
                }
              } else {
                final transactions = snapshot.data!.transactions ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(24),
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                      decoration: BoxDecoration(
                          color: Color(0xffFAFAFA),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Color(0xffEEEEEE), width: 1)),
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          cText(
                              text: 'الرصيد الكلي',
                              style: AppTextStyle.boldBlack24),
                          Row(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cText(
                                  text: snapshot.data!.currentBalance ?? '0',
                                  style: AppTextStyle.boldBlack40),
                              cText(
                                  text: '',
                                  isPrice: true,
                                  style: AppTextStyle.semiBoldBlack18),
                            ],
                          )
                        ],
                      ),
                    ),
                    cText(
                        text: 'المعاملات',
                        style: AppTextStyle.semiBoldBlack18,
                        pTop: 10,
                        pRight: 24),
                    Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.only(
                              top: 18, bottom: 80, right: 12, left: 12),
                          itemBuilder: (context, index) {
                            var transaction = transactions[index];
                            return TransactionCard(transaction: transaction);
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              color: BorderColor.grey1,
                              height: 1,
                              width: double.infinity,
                            );
                          },
                          itemCount: transactions.length),
                    ),
                  ],
                );
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: DefaultButton(
              loading: walletProvide.loading,
              text: 'السحب',
              pressed: () {
                showWithdrawSheet(
                    context: context, walletProvider: walletProvide);
              },
              activated: true),
        ),
      );
    });
  }

  void showWithdrawSheet({
    required BuildContext context,
    required WalletProvider walletProvider,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
                height: 450,
                padding: EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    cText(text: 'السحب', style: AppTextStyle.semiBoldBlack18),
                    DefaultFormField(
                      hint: 'المبلغ',
                        contoller: amountController,
                        type: TextInputType.number),
                    DefaultButton(
                        loading: walletProvider.loading,
                        text: 'السحب',
                        pressed: () {
                          walletProvider.withdraw(
                              context, double.parse(amountController.text));
                        },
                        activated: true),
                  ],
                ));
          },
        );
      },
    ).then((value) {
      amountController.clear();
      if (value != null) {
        print('yesyt');

      }
    });
  }
}
