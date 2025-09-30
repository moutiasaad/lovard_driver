// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:gift_delivery_app/shared/language/extension.dart';
// import 'package:gift_delivery_app/shared/local/cash_helper.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../shared/components/snack_bar/snack_bar.dart';
// import '../shared/remote/dio_helper.dart';
//
// class LocationProvider extends ChangeNotifier {
//   bool loading = false;
//
//   Future<Map<String, dynamic>?> fetchLocationDetails() async {
//     try {
//       var permissionStatus = await Geolocator.checkPermission();
//       LocationPermission permission;
//
//       if (permissionStatus == LocationPermission.always ||
//           permissionStatus == LocationPermission.whileInUse) {
//         print('Location permission granted.');
//       } else if (permissionStatus == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           return Future.error('Location permissions  denied');
//         }
//       } else if (permissionStatus == LocationPermission.deniedForever) {
//         print(
//             'Location permission permanently denied. Please enable it from settings.');
//         await openAppSettings();
//         return null;
//       }
//
//       if (!await Geolocator.isLocationServiceEnabled()) {
//         print('Location services are disabled.');
//         bool locationEnabled = await _promptToEnableLocation();
//         if (!locationEnabled) {
//           print('User did not enable location services.');
//           return null;
//         }
//       }
//       print('Location services are enabled.');
//
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       print('Latitude: ${position.latitude}');
//       print('Longitude: ${position.longitude}');
//
//       Map<String, dynamic>? addressDetails = await _getPlaceName(
//         position.latitude,
//         position.longitude,
//       );
//
//       return {
//         "latitude": position.latitude,
//         "longitude": position.longitude,
//         "address":
//             '${addressDetails?['country']}, ${addressDetails?['city']}, ${addressDetails?['street']}',
//       };
//     } catch (e) {
//       print('Error fetching location details: $e');
//       return null;
//     }
//   }
//
//   Future<bool> _promptToEnableLocation() async {
//     try {
//       return await Geolocator.openLocationSettings();
//     } catch (e) {
//       print('Error prompting user to enable location: $e');
//       return false;
//     }
//   }
//
//   Future<Map<String, dynamic>?> _getPlaceName(
//       double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         print('Country: ${place.country}');
//         print('City: ${place.locality}');
//         print('Street: ${place.street}');
//
//         return {
//           "country": place.country ?? '',
//           "city": place.locality ?? '',
//           "street": place.street ?? '',
//         };
//       }
//       return null;
//     } catch (e) {
//       print('Error getting place name: $e');
//       return null;
//     }
//   }
//
//   Future<void> setLocation(BuildContext context) async {
//     loading = true;
//     notifyListeners();
//     print('yesy');
//
//     try {
//       Map<String, dynamic>? locationDetail = await fetchLocationDetails();
//       print('done');
//       final response =
//           await DioHelper.postData(url: 'location/set-location', data: {
//         "address": locationDetail!['address'],
//         "longitude": double.parse(locationDetail['longitude'].toString()),
//         "latitude": double.parse(locationDetail['latitude'].toString())
//       });
//       print(response.data);
//       await getLocation(context);
//     } catch (error) {
//       print('zqs');
//       print(error);
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         loading = false;
//         notifyListeners();
//
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.connection'));
//         return Future.error('connection timeout');
//       } else if (error is DioException) {
//         loading = false;
//         notifyListeners();
//
//         ShowErrorSnackBar(
//             context, context.translate('errorsMessage.setLocation'));
//         return Future.error('connection $error');
//       } else {
//         loading = false;
//         notifyListeners();
//
//         return Future.error('connection other');
//       }
//     }
//   }
//
//   Future<void> getLocation(BuildContext context) async {
//     try {
//       final response = await DioHelper.getData(url: 'location/get-location');
//
//       print(response.data);
//       print(response.statusCode);
//
//       CashHelper.storeLocation(response.data['address'] ?? '');
//       loading = false;
//       notifyListeners();
//       Navigator.pop(context);
//     } catch (error) {
//       if (error is DioException &&
//           (error.type == DioExceptionType.connectionTimeout ||
//               error.type == DioExceptionType.connectionError)) {
//         loading = false;
//         notifyListeners();
//         return await Future.error('connection timeout');
//       } else if (error is DioException) {
//         loading = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       } else {
//         loading = false;
//         notifyListeners();
//         return await Future.error('connection other');
//       }
//     }
//   }
// }
