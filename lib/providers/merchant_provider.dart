// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/merchant_model.dart';
//
// import '../shared/remote/dio_helper.dart';
//
// class MerchantProvider extends ChangeNotifier {
//   final List<MerchantModel> _merchant = [];
//
//   List<MerchantModel> get merchant => _merchant;
//   final List<MerchantModel> _merchantSearch = [];
//
//   List<MerchantModel> get merchantSearch => _merchantSearch;
//
//   late MerchantModel _merchantData;
//
//   MerchantModel get merchantData => _merchantData;
//
//   Future<void> getMerchant() async {
//     try {
//       final response = await DioHelper.getData(url: 'merchants');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<MerchantModel> result =
//             data.map((item) => MerchantModel.fromJson(item)).toList();
//         _merchant.clear();
//         _merchant.addAll(result);
//       } else {
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
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
//   Future<List<MerchantModel>> getMerchantByType(int type) async {
//     try {
//       final response = await DioHelper.getData(url: 'merchants/type/$type');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<MerchantModel> result =
//             data.map((item) => MerchantModel.fromJson(item)).toList();
//
//         return result;
//       } else {
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
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
//   Future<MerchantModel> getMerchantById({
//     required int id,
//   }) async {
//     try {
//       final response =
//           await DioHelper.getData(url: 'merchants', urlParam: '/$id');
//
//       print(response.data);
//       print(response.statusCode);
//
//       if (response.statusCode == 200) {
//         print(response.data);
//         final Map<String, dynamic> data = response.data;
//         _merchantData = MerchantModel.fromJson(data);
//         return _merchantData;
//       } else {
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
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
