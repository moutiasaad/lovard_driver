import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';


import '../shared/local/cash_helper.dart';
import '../shared/local/secure_cash_helper.dart';
import '../shared/remote/dio_helper.dart';
import '../shared/snack_bar/snack_bar.dart';
import '../view/login/login_layout.dart';


class ProfileProvider extends ChangeNotifier {
  bool loading = false;


  Future<void> deleteAccount(BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      final response =  await DioHelper.postData(
        url: 'destroy-account',
      );
  if(response.statusCode == 200){
    await CashHelper.clearData();
    await SecureCashHelper.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginLayout(),
        ));
  }
      loading = false;
      notifyListeners();
    } catch (error) {
      print('zqs');
      print(error);
      if (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.connectionError)) {
        loading = false;
        notifyListeners();

        ShowErrorSnackBar(
            context, context.translate('errorsMessage.connection'));
        return Future.error('connection timeout');
      } else if (error is DioException) {
        loading = false;
        notifyListeners();
        ShowErrorSnackBar(
            context, context.translate('errorsMessage.deleteAccount'));
        return Future.error('connection $error');
      } else {
        loading = false;
        notifyListeners();
        return Future.error('connection other');
      }
    }
  }

}
