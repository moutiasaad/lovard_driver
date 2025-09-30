// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/promotion_model.dart';
//
// import '../shared/remote/dio_helper.dart';
//
// class PromotionProvider extends ChangeNotifier {
//   Future<List<PromotionModel>> getPromotion() async {
//     try {
//       final response = await DioHelper.getData(url: 'promotions');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<PromotionModel> result =
//             data.map((item) => PromotionModel.fromJson(item)).toList();
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
