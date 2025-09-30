import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovard_delivery_app/models/static_model/filter_types.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:lovard_delivery_app/view/orders/component/my_order_card.dart';
import 'package:lovard_delivery_app/view/orders/component/order_card.dart';
import 'package:provider/provider.dart';
import '../../../models/enum/order_status.dart';
import '../../../shared/components/appBar/design_sheet_app_bar.dart';
import '../../../utils/app_dimens.dart';
import '../../providers/order_provider.dart';
import '../../shared/components/buttons/default_button.dart';
import '../../shared/components/buttons/default_outlined_button.dart';
import '../../shared/components/image/image_net.dart';
import '../../shared/components/image/svg_icon.dart';
import '../../shared/components/text/CText.dart';
import '../../shared/error/error_component.dart';
import '../../shared/logique_function/date_functions.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/colors.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, this.profile = false});

  final bool profile;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return Scaffold(
          appBar: designSheetAppBar(
            isLeading: false,
            isCentred: false,
            icon: Icons.arrow_back,
            text: 'سجل طلباتي',
            context: context,
            style: AppTextStyle.semiBoldBlack18

          ),
          body: FutureBuilder(
              future: orderProvider.getOrder(filter: FilterTypes.assigned),
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
                  final orders = orderProvider.order;
                  print(orders.length);
                  return ListView.separated(
                      padding: const EdgeInsets.only(
                          top: 18, bottom: 80, right: 18, left: 18),
                      itemBuilder: (context, index) {
                        var order = orders[index];
                        return MyOrderCard(order: order);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 4.0);
                      },
                      itemCount: orders.length);
                }
              }));
    });
  }
}
