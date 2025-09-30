// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/ads_model.dart';
// import 'package:gift_delivery_app/models/dedication_model.dart';
//
// import '../shared/remote/dio_helper.dart';
//
// class AdsProvider extends ChangeNotifier {
//
//
//   Future<AdsModel?> getAdds() async {
//     try {
//       final response = await DioHelper.getData(url: 'promotions/ads',
//      );
//       print(response.data);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic>? data = response.data['data'];
//         if (data == null) {
//           return null;
//         }
//         else{
//           final AdsModel result = AdsModel.fromJson(data);
//
//           return result;
//         }
//       } else {
//         return null;
//       }
//     } catch (error) {
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         return null;
//       } else if (error is DioException) {
//         return null;
//       } else {
//         return null;
//       }
//     }
//   }
// }
