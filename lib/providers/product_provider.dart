// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gift_delivery_app/models/product_model.dart';
// import 'package:gift_delivery_app/shared/language/extension.dart';
//
// import '../shared/components/snack_bar/snack_bar.dart';
// import '../shared/remote/dio_helper.dart';
//
// class ProductProvider extends ChangeNotifier {
//   final List<ProductModel> _product = [];
//
//   List<ProductModel> get product => _product;
//
//   late ProductModel _productData;
//
//   ProductModel get productData => _productData;
//
//   Future<void> getProduct(String type) async {
//     Map<String, dynamic> query = {};
//     type.isEmpty ? query = {} : query = {"price": type == "1" ? "asc" : "desc"};
//
//     try {
//       final response = await DioHelper.getData(url: 'products', query: query);
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<ProductModel> result =
//             data.map((item) => ProductModel.fromJson(item)).toList();
//         _product.clear();
//         _product.addAll(result);
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
//   Future<List<ProductModel>> getProductByMerchantId(int id, String type) async {
//     Map<String, dynamic> query = {};
//     type.isEmpty ? query = {} : query = {"price": type == "1" ? "asc" : "desc"};
//     try {
//       final response =
//           await DioHelper.getData(url: 'merchants/$id/products', query: query);
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<ProductModel> result =
//             data.map((item) => ProductModel.fromJson(item)).toList();
//         return result;
//         // _product.clear();
//         // _product.addAll(result);
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
//   Future<List<ProductModel>> getCustomizableProductByMerchantId(int id) async {
//     try {
//       final response =
//           await DioHelper.getData(url: 'merchants/$id/custom_products');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<ProductModel> result =
//             data.map((item) => ProductModel.fromJson(item)).toList();
//         return result;
//         // _product.clear();
//         // _product.addAll(result);
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
//   Future<void> getProductByCategorie(int id) async {
//     try {
//       final response = await DioHelper.getData(url: 'categories/$id/products');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         List<ProductModel> result =
//             data.map((item) => ProductModel.fromJson(item)).toList();
//         _product.clear();
//         _product.addAll(result);
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
//   Future<void> getProductById({
//     required int id,
//   }) async {
//     try {
//       final response =
//           await DioHelper.getData(url: 'products', urlParam: '/$id');
//
//       print(response.data);
//       print(response.statusCode);
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = response.data;
//         _productData = ProductModel.fromJson(data);
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
//   Future<void> getFavoriteProducts() async {
//     try {
//       final response = await DioHelper.getData(url: 'wishlist');
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         if (data.isEmpty) {
//           return Future.error('Failed to load data');
//         }
//         List<ProductModel> result =
//             data.map((item) => ProductModel.fromJson(item)).toList();
//         _product.clear();
//         _product.addAll(result);
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
//   Future<void> addToFavorite(BuildContext context, int id) async {
//     try {
//       await DioHelper.postData(
//         url: 'wishlist/$id',
//       );
//     } catch (error) {
//       print('zqs');
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//
//         return Future.error('connection timeout');
//       } else if (error is DioException) {
//
//         return Future.error('connection $error');
//       } else {
//         return Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> removeFromFavorite(BuildContext context, int id) async {
//     try {
//       await DioHelper.deleteData(
//         url: 'wishlist/$id',
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
//             context, context.translate('errorsMessage.removeFavorite'));
//         return Future.error('connection $error');
//       } else {
//         return Future.error('connection other');
//       }
//     }
//   }
//
//   void sortProductsByPrice(int order) {
//     _product.sort((a, b) {
//       double priceA = double.tryParse(a.price ?? '0') ?? 0.0;
//       double priceB = double.tryParse(b.price ?? '0') ?? 0.0;
//
//       if (order == 1) {
//         return priceA.compareTo(priceB);
//       } else {
//         return priceB.compareTo(priceA);
//       }
//     });
//     notifyListeners();
//   }
// }
