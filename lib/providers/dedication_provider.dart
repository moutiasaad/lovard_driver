// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/dedication_model.dart';
//
// import '../shared/remote/dio_helper.dart';
//
// class DedicationProvider extends ChangeNotifier {
//   final List<DedicationModel> _dedication = [];
//
//   List<DedicationModel> get dedication => _dedication;
//
//   Future<List<CategoryModel>> getDedication() async {
//     try {
//       final response = await DioHelper.getData(url: 'dedications');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = response.data;
//         List<CategoryModel> result = CategoryModel.fromJsonMap(data);
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
