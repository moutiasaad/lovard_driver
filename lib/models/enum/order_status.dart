import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';

import '../../utils/app_text_styles.dart';
import '../../utils/colors.dart';


/// Enum representing possible order statuses
enum OrderStatus {
  awaitingReview,
  awaitingPayment,
  shipping,
  received,
  canceled,
  unknown;

  /// Method to get the Arabic label for the status
  String get label {
    switch (this) {
      case OrderStatus.awaitingReview:
        return 'بانتظار المراجعة';
      case OrderStatus.awaitingPayment:
        return 'بانتظار الدفع';
      case OrderStatus.shipping:
        return 'قيد الشحن';
      case OrderStatus.received:
        return 'تم الاستلام';
      case OrderStatus.canceled:
        return 'ملغاة';
      case OrderStatus.unknown:
      default:
        return 'غير معروف';
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case OrderStatus.awaitingReview:
        return AppTextStyle.waitingReviewStyle;
      case OrderStatus.awaitingPayment:
        return AppTextStyle.waitingPaymentStyle;
      case OrderStatus.shipping:
        return AppTextStyle.shiPingStyle;
      case OrderStatus.received:
        return AppTextStyle.receivedStyle;
      case OrderStatus.canceled:
        return AppTextStyle.canceledStyle;
      case OrderStatus.unknown:
      default:
        return AppTextStyle.regularBlack1_14;
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.awaitingReview:
        return StatusColor.waitingReview;
      case OrderStatus.awaitingPayment:
        return StatusColor.waitingPayment;
      case OrderStatus.shipping:
        return StatusColor.shiPing;
      case OrderStatus.received:
        return StatusColor.received;
      case OrderStatus.canceled:
        return StatusColor.canceled;
      case OrderStatus.unknown:
      default:
        return TextColor.black1;
    }
  }

  /// Parses a string status into the corresponding enum value
  static OrderStatus fromString(String? value) {
    switch (value) {
      case 'بانتظار المراجعة':
        return OrderStatus.awaitingReview;
      case 'بانتظار الدفع':
        return OrderStatus.awaitingPayment;
      case 'قيد الشحن':
        return OrderStatus.shipping;
      case 'تم الاستلام':
        return OrderStatus.received;
      case 'ملغاة':
        return OrderStatus.canceled;
      default:
        return OrderStatus.unknown;
    }
  }
}
