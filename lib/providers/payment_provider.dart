// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/view/userApp/payment/component.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
//
// import '../shared/remote/dio_helper.dart';
// import '../view/userApp/payment/payment_error_screen.dart';
//
// class PaymentProvider extends ChangeNotifier {
//   bool loading = false;
//   bool openPaymentLoad = false;
//
//   executeRegularPayment({
//     required BuildContext context,
//     required int paymentMethodId,
//     required String price,
//     required int orderId,
//     required String paymentMethodeName,
//   }) async {
//     openPaymentLoad = true;
//     notifyListeners();
//     var request = MFExecutePaymentRequest(
//       paymentMethodId: paymentMethodId,
//       invoiceValue: double.parse(price),
//       language: MFLanguage.ARABIC,
//     );
//     request.displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;
//     MFSDK.setUpActionBar(
//         toolBarTitle: 'Lovard',
//         toolBarTitleColor: "#FFFFFF",
//         toolBarBackgroundColor: '#B89EC6',
//         isShowToolBar: true);
//
//     await MFSDK.executePayment(request, MFLanguage.ARABIC, (invoiceId) {
//       openPaymentLoad = false;
//       notifyListeners();
//       print(invoiceId);
//     }).then((value) {
//       openPaymentLoad = false;
//       notifyListeners();
//       PaymentWithCard(
//           context,
//           paymentMethodeName,
//           value.invoiceTransactions![0].paymentId.toString(),
//           orderId,
//           double.parse(price));
//       print('------------------------------');
//       print(value);
//     }).catchError((error) {
//       openPaymentLoad = false;
//       notifyListeners();
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentErrorScreen(
//                 orderId: orderId.toString(),
//                 price: double.parse(price.toString())),
//           ));
//       print('------------------------------');
//       print(error.message);
//     });
//   }
//
//   PaymentWithCard(BuildContext context, String paymentMethodeName,
//       String paymentId, int orderId, double price) async {
//     try {
//       loading = true;
//       notifyListeners();
//       showLoaderPaymentDialog(context);
//       final response = await DioHelper.postData(
//         url: 'orders/makePayment',
//         data: {
//           "payment_id": paymentId.toString(),
//           "order_id": orderId,
//           "payment_methode": paymentMethodeName,
//           "amount": price
//         },
//       ); // Replace with your API endpoint
//
//       print(response.statusCode);
//       print(response.data);
//       print(response);
//       if (response.statusCode == 200) {
//         loading = false;
//         notifyListeners();
//         Navigator.pop(context);
//         showSuccessPaymentDialog(context);
//       } else {
//         loading = false;
//         notifyListeners();
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PaymentErrorScreen(
//                 orderId: orderId.toString(),
//                 price: price,
//               ),
//             ));
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       print('zqs');
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         // Handle connection timeout error
//         print('zss');
//         loading = false;
//         notifyListeners();
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PaymentErrorScreen(
//                 orderId: orderId.toString(),
//                 price: price,
//               ),
//             ));
//         return Future.error('connection timeout');
//       } else if (error is DioException) {
//         print(error.response!.statusCode);
//         loading = false;
//         notifyListeners();
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PaymentErrorScreen(
//                 orderId: orderId.toString(),
//                 price: price,
//               ),
//             ));
//         return Future.error('connection $error');
//       } else {
//         loading = false;
//         notifyListeners();
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PaymentErrorScreen(
//                 orderId: orderId.toString(),
//                 price: price,
//               ),
//             ));
//         return Future.error('connection other');
//       }
//     }
//   }
// }
