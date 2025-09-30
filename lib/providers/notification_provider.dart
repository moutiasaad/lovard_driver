import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:lovard_delivery_app/models/notification_model.dart';

import '../shared/remote/dio_helper.dart';

class NotificationProvider extends ChangeNotifier {
  Future<List<NotificationModel>> getNotification() async {
    try {
      final response = await DioHelper.getData(url: 'drivers/notification');

      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<NotificationModel> result =
            data.map((item) => NotificationModel.fromJson(item)).toList();
        print(result);
        return result;
      } else {
        return Future.error('Failed to load data');
      }
    } catch (error) {
      print(error);
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        return await Future.error('connection timeout');
      } else if (error is DioException) {
        return await Future.error('connection other');
      } else {
        return await Future.error('connection other');
      }
    }
  }
}
