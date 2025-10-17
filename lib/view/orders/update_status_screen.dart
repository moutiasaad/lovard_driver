import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/enum/order_status.dart';
import '../../../providers/order_provider.dart';
import '../../../shared/components/appBar/design_sheet_app_bar.dart';
import '../../../shared/components/buttons/default_button.dart';
import '../../../shared/components/image/image_net.dart';
import '../../../shared/components/text/CText.dart';
import '../../../shared/logique_function/date_functions.dart';
import '../../../shared/logique_function/time_function.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/colors.dart';
import 'package:intl/intl.dart';
import '../../models/order_model.dart';
import '../../shared/components/buttons/cancel_button.dart';
import '../../shared/components/buttons/default_outlined_button.dart';
import '../../shared/components/image/svg_icon.dart';
import '../../shared/components/map/map_component.dart';
import '../../utils/app_dimens.dart';
import '../../utils/app_icons.dart';

class UpdateStatusScreen extends StatefulWidget {
  const UpdateStatusScreen({super.key, required this.data});

  final OrderModel data;

  @override
  State<UpdateStatusScreen> createState() => _UpdateStatusScreenState();
}

class _UpdateStatusScreenState extends State<UpdateStatusScreen> {
  late String orderDate;
  bool _isMapInteracting = false;

  void _setMapGesture(bool isInteracting) {
    setState(() {
      _isMapInteracting = isInteracting;
    });
  }

  @override
  void initState() {
    Future.microtask(() => context.read<OrderProvider>().getDriverStatuses(
      driverId: context.read<OrderProvider>().userId,
    ));
    orderDate = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      print("sttttttttttttttttttttttttt"+widget.data.merchant!.whatsapp.toString());
      final isAccepted = widget.data.status == "تم قبول الطلب";

      return Scaffold(
        appBar: AppBar(
          leading: CancelButton(
            context: context,
            icon: Icons.arrow_back,
          ),
          title: cText(
            text: context.translate('order.orderDetail.orderNumber') +
                ' ' +
                widget.data.id.toString() +
                '#',
            style: AppTextStyle.semiBoldBlack14,
          ),
          elevation: 0.5,
          backgroundColor: BackgroundColor.background,
        ),
        backgroundColor: BackgroundColor.background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Conditional map rendering
              SizedBox(
                height: 400,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isAccepted
                      ? MapScreenComponent(
                    zoom: 12,
                    merchantName: widget.data.merchant!.name!,
                    userName: widget.data.fullName,
                    latitudeS: double.parse(widget.data.latitudeM!),
                    longitudeS: double.parse(widget.data.longitudeM!),
                    onFullScreen: true,
                  )
                      : MapScreenComponent(
                    zoom: 12,
                    merchantName: widget.data.merchant!.name!,
                    userName: widget.data.fullName,
                    latitudeS: double.parse(widget.data.latitudeM!),
                    longitudeS: double.parse(widget.data.longitudeM!),
                    latitudeC: double.parse(widget.data.latitudeC!),
                    longitudeC: double.parse(widget.data.longitudeM!),
                    onFullScreen: true,
                  ),
                ),
              ),

              // ✅ Conditional contact section
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                        SvgIcon(
                          icon: AppIcons.profileFill,
                          width: 24,
                          height: 24,
                        ),
                        cText(
                          text: context
                              .translate('order.orderDetail.marchent'),
                          style: AppTextStyle.semiBoldPrimary20,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        cText(
                          text: widget.data.merchant!.name ?? '',
                          style: AppTextStyle.semiBoldBlack14,
                        ),
                        !widget.data.merchant!.whatsapp!.isEmpty ? Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ✅ WhatsApp number
                            InkWell(
                              onTap: () async {
                                final whatsappNumber =
                                    widget.data.merchant?.whatsapp ?? '';
                                final orderId = widget.data.lines
                                    ?.driverOrderId
                                    ?.toString() ??
                                    '';

                                if (whatsappNumber.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text('رقم واتساب غير متوفر'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  return;
                                }

                                final message = Uri.encodeComponent(
                                  'مرحبًا، أود الاستفسار عن الطلب رقم $orderId',
                                );
                                final url = Uri.parse(
                                    'https://wa.me/$whatsappNumber?text=$message');

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content:
                                      Text('تعذر فتح تطبيق واتساب'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                widget.data.merchant?.whatsapp ?? '',
                                style: AppTextStyle.regularBlack1_14,
                              ),
                            ),
                            // ✅ WhatsApp Icon clickable
                            widget.data.merchant?.whatsapp != null ? InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final whatsappNumber =
                                    widget.data.merchant?.whatsapp ?? '';
                                final orderId = widget.data.lines
                                    ?.driverOrderId
                                    ?.toString() ??
                                    '';

                                if (whatsappNumber.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text('رقم واتساب غير متوفر'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  return;
                                }

                                final message = Uri.encodeComponent(
                                  'مرحبًا، أود الاستفسار عن الطلب رقم $orderId',
                                );
                                final url = Uri.parse(
                                    'https://wa.me/$whatsappNumber?text=$message');

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content:
                                      Text('تعذر فتح تطبيق واتساب'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              },
                              child: SvgIcon(
                                icon: AppIcons.whatsapp,
                                width: 22,
                                height: 22,
                                color: const Color(0xFF25D366),
                              ),
                            ):cText(
                              text: '_',
                              style: AppTextStyle.semiBoldBlack14,
                            ),
                          ],
                        ):cText(
                          text: '-',
                          style: AppTextStyle.semiBoldBlack14,
                        ),
                      ],
                    )
                  ],
                ),
              ),
             ! isAccepted
                  ?   Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        cText(
                          text: widget.data.fullName ?? '',
                          style: AppTextStyle.semiBoldBlack14,
                        ),
                        cText(
                          text: widget.data.phone ?? '',
                          style: AppTextStyle.regularBlack1_14,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BackgroundColor.grey1,
                      ),
                      child: SvgIcon(icon: AppIcons.phone),
                    ),
                  ],
                ),
              ): Text(""),

              // ---- Keep rest of your screen unchanged ----
              Container(
                width: double.infinity,
                height: 1,
                color: BorderColor.grey1,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: cText(
                  text: widget.data.address ?? '',
                  style: AppTextStyle.semiBoldBlack14,
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: BorderColor.grey1,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                        SvgIcon(
                          icon: AppIcons.orderFill,
                          width: 24,
                          height: 24,
                        ),
                        cText(
                            text: context
                                .translate('order.orderDetail.orderStatus'),
                            style: AppTextStyle.semiBoldPrimary20),
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left side (status dots and lines)
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 8, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                  widget.data.orderStatus!.length, (index) {
                                bool isLast = index ==
                                    widget.data.orderStatus!.length - 1;
                                final item = widget.data.orderStatus![index];
                                return Column(
                                  children: [
                                    // Circle Dot
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: item.status == '1'
                                              ? AppColors.primary
                                              : BorderColor.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                            color: item.status == '1'
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Dotted line (only if not last item)
                                    if (!isLast)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: DottedLine(
                                          direction: Axis.vertical,
                                          lineLength: 45,
                                          lineThickness: 2.0,
                                          dashLength: 4.0,
                                          dashColor: AppColors.primary,
                                          dashGapLength: 4.0,
                                        ),
                                      ),
                                  ],
                                );
                              }),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    widget.data.orderStatus!.length, (index) {
                                  final item = widget.data.orderStatus![index];
                                  print(item.date);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 28),
                                    // space between steps
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        cText(
                                          text: item.title ?? 'Title',
                                          style: AppTextStyle.mediumBlack14,
                                        ),
                                        cText(
                                          text: item.date == '-'
                                              ? '--'
                                              : convertToArabicDate(
                                              item.date ?? ''),
                                          style: AppTextStyle.regularBlack1_14,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultButton(
                      raduis: 6,
                      text: context.translate('buttons.updateOrder'),
                      pressed: () {
                        _showStatusSheet(
                            order: orderProvider, orderId: widget.data.id!);
                      },
                      activated: true,
                    ),
                  ],
                ),
              ),
              // Rest of content (statuses, button, etc.) remains the same...
            ],
          ),
        ),
      );
    });
  }
  void _showStatusSheet({
    required OrderProvider order,
    required int orderId,
  })
  {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        int? _selectedStatusId;

        return StatefulBuilder(
          builder: (context, setModalState) {
            final loading = order.statusesLoading;
            final items = order.driverStatuses; // List<DriverStatus>

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (loading) ...[
                    const SizedBox(height: 8),
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 16),
                  ] else if (items.isEmpty) ...[
                    cText(
                      text: context.translate('errorsMessage.connection'),
                      style: AppTextStyle.semiBoldBlack14,
                    ),
                    const SizedBox(height: 16),
                  ] else ...[
                    Column(
                      spacing: 10,
                      children: items.map((status) {
                        final isSelected = status.id == _selectedStatusId;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              _selectedStatusId = status.id;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.secondary
                                  : BackgroundColor.grey2,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.secondary
                                    : BorderColor.grey1,
                              ),
                            ),
                            child: Center(
                              child: cText(
                                text: status.statusName, // from API
                                style: isSelected
                                    ? AppTextStyle.semiBoldWhite14
                                    : AppTextStyle.semiBoldBlack14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    DefaultButton(
                      activated: _selectedStatusId != null,
                      loading: order.updateStatus,
                      text: context.translate('buttons.updateOrder'),
                      raduis: 6,
                      pressed: () {
                        if (_selectedStatusId == null || order.updateStatus) return;
                        order.updateOrderStatus(
                          context: context,
                          orderId: orderId,
                          status: _selectedStatusId!,
                        );
                      },
                    )

                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
