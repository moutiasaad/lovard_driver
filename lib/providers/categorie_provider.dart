// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// import '../models/categorie_model.dart';
// import '../shared/remote/dio_helper.dart';
//
// class CategorieProvider extends ChangeNotifier {
//   final List<CategorieModel> _categorie = [];
//
//   List<CategorieModel> get categorie => _categorie;
//
//   late CategorieModel _categorieData;
//
//   CategorieModel get categorieData => _categorieData;
//
//   Future<void> getCategorie() async {
//     try {
//       final response = await DioHelper.getData(url: 'categories');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<CategorieModel> result =
//             data.map((item) => CategorieModel.fromJson(item)).toList();
//         _categorie.clear();
//         _categorie.addAll(result);
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
//   Future<void> getCategorieById({
//     required int id,
//   }) async {
//     try {
//       final response =
//           await DioHelper.getData(url: 'categories', urlParam: '/$id');
//
//       print(response.data);
//       print(response.statusCode);
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = response.data;
//         _categorieData = CategorieModel.fromJson(data);
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
