// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/merchant_model.dart';
// import 'package:gift_delivery_app/models/product_model.dart';
//
// import '../shared/remote/dio_helper.dart';
//
// class SearchProvider extends ChangeNotifier {
//   final List<ProductModel> _product = [];
//
//   List<ProductModel> get product => _product;
//   final List<MerchantModel> _merchant = [];
//
//   List<MerchantModel> get merchant => _merchant;
//
//   Timer? _debounce;
//   bool _isFetching = false;
//   String _searchQueryProduct = '';
//   String _searchQueryMerchant = '';
//
//   bool get isFetching => _isFetching;
//
//   String get searchQueryProduct => _searchQueryProduct;
//
//   String get searchQueryMerchant => _searchQueryMerchant;
//
//   void setSearchQueryProduct(String query) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       _searchQueryProduct = query;
//       _product.clear();
//       getProductSearch(searchQuery: query);
//     });
//   }
//
//   void setSearchQueryMerchant(String query) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       _searchQueryMerchant = query;
//       merchant.clear();
//       getMerchantSearch(searchQuery: query);
//     });
//   }
//
//   Future<void> getProductSearch({
//     String? searchQuery,
//   }) async {
//     if (_isFetching) return;
//     _isFetching = true;
//     notifyListeners();
//     try {
//       final response = await DioHelper.getData(
//           url: 'products/search/', urlParam: searchQuery ?? '');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<ProductModel> result =
//             data.map((item) => ProductModel.fromJson(item)).toList();
//         _product.clear();
//         _product.addAll(result);
//         _isFetching = false;
//         notifyListeners();
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection timeout');
//       } else if (error is DioException) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> getMerchantSearch({
//     String? searchQuery,
//   }) async {
//     if (_isFetching) return;
//     _isFetching = true;
//     notifyListeners();
//     try {
//       final response = await DioHelper.getData(
//           url: 'merchants/search/', urlParam: searchQuery ?? '');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<MerchantModel> result =
//             data.map((item) => MerchantModel.fromJson(item)).toList();
//         _merchant.clear();
//         _merchant.addAll(result);
//         _isFetching = false;
//         notifyListeners();
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection timeout');
//       } else if (error is DioException) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> getProduct() async {
//     if (_isFetching) return;
//     _isFetching = true;
//     notifyListeners();
//     try {
//       final response = await DioHelper.getData(url: 'products');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<ProductModel> result =
//             data.map((item) => ProductModel.fromJson(item)).toList();
//         _product.clear();
//         _product.addAll(result);
//         _isFetching = false;
//         notifyListeners();
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection timeout');
//       } else if (error is DioException) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> getMerchant() async {
//     if (_isFetching) return;
//     _isFetching = true;
//     notifyListeners();
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
//         _isFetching = false;
//         notifyListeners();
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return Future.error('Failed to load data');
//       }
//     } catch (error) {
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection timeout');
//       } else if (error is DioException) {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       } else {
//         _isFetching = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       }
//     }
//   }
// }
