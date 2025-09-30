// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/shared/language/extension.dart';
//
// import '../shared/components/snack_bar/snack_bar.dart';
// import '../shared/remote/dio_helper.dart';
//
// class WhitListProvider extends ChangeNotifier {
//   bool loading = false;
//   bool addLoading = false;
//   bool removeLoading = false;
//   Map<String, dynamic> errors = {};
//
//   Future<void> addToFavorite(BuildContext context, String id) async {
//     addLoading = true;
//     notifyListeners();
//
//     try {
//       await DioHelper.postData(
//         url: 'wishlist/$id',
//       );
//
//       addLoading = false;
//       notifyListeners();
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
//             context, context.translate('errorsMessage.addWhiteList'));
//         return Future.error('connection $error');
//       } else {
//         addLoading = false;
//         notifyListeners();
//         return Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> removeFromFavorite(BuildContext context, String id) async {
//     addLoading = true;
//     notifyListeners();
//
//     try {
//       await DioHelper.deleteData(
//         url: 'wishlist/$id',
//       );
//
//       addLoading = false;
//       notifyListeners();
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
//             context, context.translate('errorsMessage.removeWhiteList'));
//         return Future.error('connection $error');
//       } else {
//         addLoading = false;
//         notifyListeners();
//         return Future.error('connection other');
//       }
//     }
//   }
// }
