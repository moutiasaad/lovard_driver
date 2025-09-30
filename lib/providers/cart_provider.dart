// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/cart_model.dart';
// import 'package:gift_delivery_app/models/create_design_model.dart';
// import 'package:gift_delivery_app/models/product_model.dart';
// import 'package:gift_delivery_app/models/static_model/static_cart_model.dart';
// import 'package:gift_delivery_app/shared/language/extension.dart';
// import 'package:gift_delivery_app/shared/local/cash_helper.dart';
// import 'package:gift_delivery_app/shared/logique_function/date_functions.dart';
// import 'package:gift_delivery_app/view/userApp/orders/make_order_screen.dart';
//
// import '../models/delivery_time_model.dart';
// import '../shared/components/snack_bar/snack_bar.dart';
// import '../shared/remote/dio_helper.dart';
//
// class CartProvider extends ChangeNotifier {
//   final List<CartModel> _cart = [];
//
//   List<CartModel> get cart => _cart;
//   bool addLoading = false;
//   int userId = CashHelper.getUserId();
//
//   Future<void> getCart() async {
//     try {
//       final response =
//           await DioHelper.getData(url: 'cart/user', urlParam: '/$userId');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         print(data);
//         List<CartModel> result =
//             data.map((item) => CartModel.fromJson(item)).toList();
//         _cart.clear();
//         _cart.addAll(result);
//       } else {
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         return await Future.error('connection timeout');
//       } else if (error is DioException) {
//         return await Future.error('connection other');
//       } else {
//         return await Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> addToCart(BuildContext context, StaticCartModel data, int type,
//       ProductModel product, CreateDesignModel customDesign) async {
//     addLoading = true;
//     notifyListeners();
//
//     try {
//       String startDate = '';
//       String endDate = '';
//       TimeOfDay? startTime = data.startTime;
//       TimeOfDay? endTime = data.endTime;
//       DateTime? date ;
//
//       switch (type) {
//         case 0:
//           startDate = combineDateTimeAndTimeOfDay(DateTime.now(), data.startTime!,'start');
//           endDate = combineDateTimeAndTimeOfDay(DateTime.now(), data.endTime!,'end');
//           date = DateTime.now();
//           break;
//         case 1:
//           startDate = combineDateTimeAndTimeOfDay(
//               DateTime.now().add(const Duration(days: 1)),
//               data.startTime!,
//               'start');
//           endDate = combineDateTimeAndTimeOfDay(
//               DateTime.now().add(const Duration(days: 1)),
//               data.endTime!,
//               'end');
//           date = DateTime.now().add(Duration(days: 1));
//           break;
//         case 2:
//           startDate = combineDateTimeAndTimeOfDay(
//               data.dates![0], data.startTime!, 'start');
//           endDate =
//               combineDateTimeAndTimeOfDay(data.dates![0], data.endTime!, 'end');
//           date = data.dates![0];
//           break;
//         // case 3:
//         //   startDate = combineDateTimeAndTimeOfDay(data.dates![0], data.startTime!,'start');
//         //   endDate = combineDateTimeAndTimeOfDay(data.dates![1], data.endTime!,'end');
//         //   break;
//       }
//
//
//       final response = await DioHelper.postData(url: 'cart', data: {
//         "product_id": data.productId,
//         "user_id": userId,
//         "qte": data.qte,
//         "preferred_delivery_start": startDate,
//         "preferred_delivery_end": endDate
//       });
//
//       data.startTime = startTime;
//       data.endTime = endTime;
//       data.dates = date != null ? [date] : [DateTime.now()];
//       print(response.data['id']);
//
//       addLoading = false;
//       notifyListeners();
//       print('dqsdqsqsdsdqqsdsdq${data.startTime} ${data.endTime} ${data.dates![0]}');
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MakeOrderScreen(
//               cartData: data,
//               cartId: response.data['id'],
//               product: product,
//               customDesign: customDesign,
//             ),
//           ));
//     } catch (error) {
//       print('zqs');
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         addLoading = false;
//         notifyListeners();
//
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.connection'));
//         return Future.error('connection timeout');
//       } else if (error is DioException) {
//         addLoading = false;
//         notifyListeners();
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.addToCart'));
//         return Future.error('connection $error');
//       } else {
//         addLoading = false;
//         notifyListeners();
//         return Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> removeFromCart(BuildContext context, int id) async {
//     try {
//       await DioHelper.deleteData(
//         url: 'cart/$id',
//       );
//     } catch (error) {
//       print('zqs');
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.connection'));
//         return Future.error('connection timeout');
//       } else if (error is DioException) {
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.removeFromCart'));
//         return Future.error('connection $error');
//       } else {
//         return Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> addRemoveQteFromCart(
//       BuildContext context, int id, int qte) async {
//     try {
//       await DioHelper.putData(url: 'cart/$id', data: {"qte": qte});
//     } catch (error) {
//       print('zqs');
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.connection'));
//         return Future.error('connection timeout');
//       } else if (error is DioException) {
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.addWhiteList'));
//         return Future.error('connection $error');
//       } else {
//         return Future.error('connection other');
//       }
//     }
//   }
//
//   Future<List<DeliveryTimeModel>> getDeliveryTime(int id) async {
//     try {
//       final response = await DioHelper.getData(url: 'delivery_times/$id');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<DeliveryTimeModel> result =
//             data.map((item) => DeliveryTimeModel.fromJson(item)).toList();
//         return result;
//       } else {
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         return await Future.error('connection timeout');
//       } else if (error is DioException) {
//         return await Future.error('connection other');
//       } else {
//         return await Future.error('connection other');
//       }
//     }
//   }
// }
