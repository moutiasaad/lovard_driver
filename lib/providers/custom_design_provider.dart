// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/custom_design_model.dart';
// import 'package:gift_delivery_app/models/custom_design_option_model.dart';
//
// import '../models/enum/create_design_model_type.dart';
// import '../shared/remote/dio_helper.dart';
//
// class CustomDesignProvider extends ChangeNotifier {
//   Future<List<CustomDesignModel>> getCustom(CreateDesignModelType type,String productId) async {
//     String url = '';
//     switch (type) {
//       case CreateDesignModelType.coverType:
//         url = 'design-attributes/${productId}/attributes/cover';
//       case CreateDesignModelType.coverColor:
//         url = 'design-attributes/${productId}/attributes/color_cover';
//       case CreateDesignModelType.tapeType:
//         url = 'design-attributes/${productId}/attributes/tape';
//       case CreateDesignModelType.tapeColor:
//         url = 'design-attributes/${productId}/attributes/color_tape';
//       default:
//         url = '';
//     }
//     try {
//       final response = await DioHelper.getData(url: url);
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data['data'];
//         List<CustomDesignModel> result =
//             data.map((item) => CustomDesignModel.fromJson(item)).toList();
//         print(result);
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
//
//   Future<List<CustomDesignOptionModel>> getCustomOption(
//       CreateDesignModelType type, String productId) async {
//     String url = '';
//     switch (type) {
//       case CreateDesignModelType.flowerType:
//         url = 'design-options/$productId/type/flower';
//       case CreateDesignModelType.cardType:
//         url = 'design-options/$productId/type/card';
//
//       default:
//         url = '';
//     }
//     try {
//       final response = await DioHelper.getData(url: url);
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data['data'];
//         List<CustomDesignOptionModel> result =
//             data.map((item) => CustomDesignOptionModel.fromJson(item)).toList();
//         print(result);
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
