import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';

import '../models/DriverStatus.dart';
import '../models/create_design_model.dart';
import '../models/enum/order_status.dart';
import '../models/order_model.dart';
import '../models/static_model/filter_types.dart';
import '../models/static_model/static_cart_model.dart';
import '../shared/local/cash_helper.dart';
import '../shared/logique_function/date_functions.dart';
import '../shared/remote/dio_helper.dart';
import '../shared/snack_bar/snack_bar.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _order = [];

  List<OrderModel> get order => _order;

  late OrderModel _orderData;

  OrderModel get orderData => _orderData;
  bool addLoading = false;
  bool updateLoading = false;
  bool assignLoading = false;
  bool updateStatus = false;
  bool unAssignLoading = false;
  bool couponLoading = false;
  bool statusesLoading = false;
  int userId = CashHelper.getUserId();
  final List<DriverStatus> _driverStatuses = [];
  List<DriverStatus> get driverStatuses => _driverStatuses;

  Future<void> getDriverStatuses({required int driverId}) async {
    statusesLoading = true;
    notifyListeners();
    try {
      final res = await DioHelper.getData(
        url: 'drivers/status',
        urlParam: '/$driverId',
        withToken: true, // keep true if endpoint requires auth
      );
      print(res.toString());
      if (res.statusCode == 200) {
        final List data = (res.data as List);
        final items = data.map((e) => DriverStatus.fromJson(e as Map<String, dynamic>)).toList();

        _driverStatuses
          ..clear()
          ..addAll(items);

        statusesLoading = false;
        notifyListeners();
      } else {
        statusesLoading = false;
        notifyListeners();
        throw 'Failed to load statuses';
      }
    } catch (error) {
      statusesLoading = false;
      notifyListeners();

      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        throw 'connection timeout';
      } else if (error is DioException) {
        throw 'connection other';
      } else {
        throw 'connection other';
      }
    }
  }
  Future<void> getOrder({
    required FilterTypes filter,
  }) async {
    try {
      final response = await DioHelper.getData(
          url: 'drivers/orders', query: {"filter": filter.value});

      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print(data);
        List<OrderModel> result =
            data.map((item) => OrderModel.fromJson(item)).toList();
        if (data.isEmpty) {
          return Future.error('Failed to load data');
        }
        _order.clear();
        _order.addAll(result);
      } else {
        return Future.error('Failed to load data');
      }
    } catch (error) {
      print(error);
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        return await Future.error('connection timeout');
      } else if (error is DioException) {
        return await Future.error('connection other');
      } else {
        return await Future.error('connection other');
      }
    }
  }

  Future<void> getOrderById({
    required int id,
  }) async {
    try {
      final response = await DioHelper.getData(url: 'orders', urlParam: '/$id');

      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        _orderData = OrderModel.fromJson(data);
      } else {
        return Future.error('Failed to load data');
      }
    } catch (error) {
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        return await Future.error('connection timeout');
      } else if (error is DioException) {
        return await Future.error('connection other');
      } else {
        return await Future.error('connection other');
      }
    }
  }

  Future<void> checkCoupon({
    required Function(double, bool) onEnd,
    required int cartId,
    required String coupon,
  }) async {
    couponLoading = true;
    notifyListeners();
    bool status = false;
    try {
      final response = await DioHelper.getData(
          url: 'orders/getPriceByCoupon/', urlParam: '$coupon/$cartId');

      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        print('lets go');
        print(data['price']);
        double newPrice = double.parse(data['price'].toString());
        status = true;
        onEnd(newPrice, status);
        couponLoading = false;

        notifyListeners();
      } else {
        couponLoading = false;
        notifyListeners();
        onEnd(0, status);
        return Future.error('Failed to load data');
      }
    } catch (error) {
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        couponLoading = false;
        notifyListeners();
        onEnd(0, status);
        return await Future.error('connection timeout');
      } else if (error is DioException) {
        couponLoading = false;
        notifyListeners();
        onEnd(0, status);
        return await Future.error('connection other');
      } else {
        couponLoading = false;
        notifyListeners();
        onEnd(0, status);
        return await Future.error('connection other');
      }
    }
  }

  Future<void> addOrder({
    required BuildContext context,
    required int cartId,
    required String address,
    required String phone,
    required String name,
    required CreateDesignModel customDesign,
    required bool hideBuyerIdentity,
    required String locationSelectedValue,
    required StaticCartModel cartData,
    double? latitude,
    double? logitude,
    int? driverId,
    String? coupon,
    String? note,
  }) async {
    addLoading = true;
    notifyListeners();
    print(cartData.startTime);
    print(cartData.dates);
    print(cartData.endTime);
    String startDate = combineDateTimeAndTimeOfDay(
        cartData.dates![0], cartData.startTime!, 'start');
    String endDate = combineDateTimeAndTimeOfDay(
        cartData.dates![0], cartData.endTime!, 'end');
    try {
      List<int> lId = [cartId];
      List<int> attributsId = [];
      List<int> optionId = [];
      customDesign.cardTypeId != null
          ? optionId.add(customDesign.cardTypeId!)
          : null;
      customDesign.flowerTypeId != null
          ? optionId.add(customDesign.flowerTypeId!)
          : null;

      customDesign.coverColorId != null
          ? attributsId.add(customDesign.coverColorId!)
          : null;
      customDesign.coverTypeId != null
          ? attributsId.add(customDesign.coverTypeId!)
          : null;
      customDesign.tapeColorId != null
          ? attributsId.add(customDesign.tapeColorId!)
          : null;
      customDesign.tapeTypeId != null
          ? attributsId.add(customDesign.tapeTypeId!)
          : null;
      Map<String, dynamic> dataSetted = {
        "cart": lId,
        "address": address,
        "phone": phone,
        "fullname": name,
        "driver_id": driverId,
        "client_note": customDesign.cardDescription!.message,
        "hide_buyer_identity": hideBuyerIdentity ? 1 : 0,
        "start_date_delivery": startDate,
        "end_date_delivery": endDate,
        "card_description": {
          "from": customDesign.cardDescription!.from,
          "to": customDesign.cardDescription!.to,
          "link": customDesign.cardDescription!.link,
          "message": customDesign.cardDescription!.message,
        }
      };
      if (locationSelectedValue == 'تحديد الموقع') {
        dataSetted.addAll({"latitude": latitude, "logitude": logitude});
      }
      if (attributsId.isNotEmpty && optionId.isNotEmpty) {
        dataSetted.addAll({
          "designOptionIds": optionId,
          "designAttributeIds": attributsId,
        });
      }
      if (coupon != null) {
        dataSetted.addAll({
          "coupon": coupon,
        });
      }

      final response =
          await DioHelper.postData(url: 'orders', data: dataSetted);

      print(response.data['order']);
      addLoading = false;
      notifyListeners();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => OrdersSuccessScreen(
      //               order: OrderModel.fromJson(response.data['order']),
      //             )));
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentChoiceScreen(data: OrderModel.fromJson(response.data['order']),)));
    } catch (error) {
      print('zqs');
      print(error);
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        addLoading = false;
        notifyListeners();

        ShowErrorSnackBar(
            context, context.translate('errorsMessage.connection'));
        return Future.error('connection timeout');
      } else if (error is DioException) {
        addLoading = false;
        notifyListeners();
        ShowErrorSnackBar(context, context.translate('errorsMessage.addOrder'));
        return Future.error('connection $error');
      } else {
        addLoading = false;
        notifyListeners();
        return Future.error('connection other');
      }
    }
  }

  Future<void> assignOrder({
    required BuildContext context,
    required int orderId,
  }) async {
    assignLoading = true;
    notifyListeners();

    try {
      final response = await DioHelper.postData(
          url: 'drivers/order/assign', data: {"order_id": orderId});

      print(response.data);
      ShowSuccesSnackBar(
          context, context.translate('successMessage.assignOrder'));
      assignLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (error) {
      print('zqs');
      print(error);
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        assignLoading = false;
        notifyListeners();

        ShowErrorSnackBar(
            context, context.translate('errorsMessage.connection'));
        return Future.error('connection timeout');
      } else if (error is DioException) {
        assignLoading = false;
        notifyListeners();
        ShowErrorSnackBar(
            context, context.translate('errorsMessage.assignOrder'));
        return Future.error('connection $error');
      } else {
        assignLoading = false;
        notifyListeners();
        return Future.error('connection other');
      }
    }
  }

  Future<void> unAssignOrder({
    required BuildContext context,
    required int orderId,
  }) async {
    unAssignLoading = true;
    notifyListeners();

    try {
      final response = await DioHelper.postData(
          url: 'drivers/order/unassign', data: {"order_id": orderId});

      print(response.data);
      ShowSuccesSnackBar(
          context, context.translate('successMessage.unAssignOrder'));
      unAssignLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (error) {
      print(error);
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        unAssignLoading = false;
        notifyListeners();

        ShowErrorSnackBar(
            context, context.translate('errorsMessage.connection'));
        return Future.error('connection timeout');
      } else if (error is DioException) {
        unAssignLoading = false;
        notifyListeners();
        ShowErrorSnackBar(
            context, context.translate('errorsMessage.unAssignOrder'));
        return Future.error('connection $error');
      } else {
        unAssignLoading = false;
        notifyListeners();
        return Future.error('connection other');
      }
    }
  }

  Future<void> updateOrder({
    required BuildContext context,
    required String paymentNote,
    required int orderId,
    required OrderModel data,
  }) async {
    updateLoading = true;
    notifyListeners();

    try {
      final response = await DioHelper.postData(
          url: 'orders/update',
          data: {"payment_note": paymentNote, "order_id": orderId});

      print(response.data);
      updateLoading = false;
      notifyListeners();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => PaymentScreen(data: data),
      //     ));
    } catch (error) {
      print('zqs');
      print(error);
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        updateLoading = false;
        notifyListeners();

        ShowErrorSnackBar(
            context, context.translate('errorsMessage.connection'));
        return Future.error('connection timeout');
      } else if (error is DioException) {
        updateLoading = false;
        notifyListeners();
        ShowErrorSnackBar(
            context, context.translate('errorsMessage.updateOrder'));
        return Future.error('connection $error');
      } else {
        updateLoading = false;
        notifyListeners();
        return Future.error('connection other');
      }
    }
  }

  Future<void> updateOrderStatus({
    required BuildContext context,
    required int orderId,
    required int status,
  }) async {
    updateStatus = true;
    notifyListeners();

    final String url = 'drivers/order/update-status';
    final Map<String, dynamic> requestData = {
      "order_id": orderId,
      "status": status,
    };

    try {
      print('🔹 [UPDATE ORDER STATUS]');
      print('➡️ URL: $url');
      print('📦 Data Sent: $requestData');

      final response = await DioHelper.postData(
        url: url,
        data: requestData,
      );

      print('✅ Response Status Code: ${response.statusCode}');
      print('✅ Response Data: ${response.data}');

      ShowSuccesSnackBar(
        context,
        context.translate('successMessage.assignOrder'),
      );

      updateStatus = false;
      notifyListeners();

      Navigator.of(context).pop(); // ✅ Just close the bottom sheet
    } catch (error) {
      print('❌ [ERROR] Failed to update order status');
      print('Error details: $error');

      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        updateStatus = false;
        notifyListeners();

        ShowErrorSnackBar(
          context,
          context.translate('errorsMessage.connection'),
        );
        return Future.error('connection timeout');
      } else if (error is DioException) {
        updateStatus = false;
        notifyListeners();

        print('❌ Dio Error Response: ${error.response?.data}');
        ShowErrorSnackBar(
          context,
          context.translate('errorsMessage.assignOrder'),
        );
        return Future.error('connection $error');
      } else {
        updateStatus = false;
        notifyListeners();
        return Future.error('connection other');
      }
    }
  }

}
