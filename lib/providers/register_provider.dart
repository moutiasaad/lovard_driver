import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/view/layout/driver_home_layout.dart';
import 'package:permission_handler/permission_handler.dart';

import '../firebase_options.dart';
import '../models/register_model.dart';

import '../models/static_model/user_model.dart';
import '../shared/components/loading/icon_loader.dart';
import '../shared/local/cash_helper.dart';
import '../shared/local/secure_cash_helper.dart';
import '../shared/remote/dio_helper.dart';

class RegisterProvider extends ChangeNotifier {
  bool loading = false;
  bool otpError = false;
  Map<String, dynamic> errors = {};

  bool get isOtpError => otpError;

  Future<void> register(RegisterModel data, BuildContext context,
      Function Forword, Function(String?) invalidNumber) async {
    // Clear previous errors
    errors = {};
    loading = true;
    notifyListeners();

    try {
      final response = await DioHelper.postData(
        withToken: false,
        url: 'drivers/register-phone',
        data: {
          "phone": data.phoneNumber,
        },
      );
      print(response);
      data.userId = response.data['driver_id'];
      //data.otp = response.data['otp'];
      loading = false;
      notifyListeners();
      Forword();
    } catch (error) {
      if (error is DioException) {
        loading = false;
        notifyListeners();
        invalidNumber(error.response?.data['message']);
        errors = error.response?.data['message'] ?? '';
        print('errrors: ${error.response?.data['message']}');
      } else {
        print("An unexpected error occurred: $error");
      }
      loading = false;
      notifyListeners();
    }
  }

  Future<void> verifierOtp(RegisterModel data, BuildContext context,
      Function Forword, int otp) async {
    otpError = false;
    notifyListeners();
    otpLoading(context);

    await handleNotificationPermission(context).then((fcmToken) async {
    try {
      final response = await DioHelper.postData(
        withToken: false,
        url: 'drivers/verify-otp',
        data: {
          "driver_id": data.userId,
          "otp": otp,
             "fcm_token": fcmToken
        },
      );

      print(response.data['token']);
      print(response.data);

      loading = false;
      notifyListeners();
      Navigator.pop(context);

      // if (response.data['redirect_to'] == '/update-profile') {
      //   data.token = response.data['token'];
      //   Forword();
      // } else {
      await SecureCashHelper.setToken(response.data['token']);
      await CashHelper.setUserId(data.userId!);
      UserModel user = UserModel(
        fullName: response.data['user']['name'],
        email: response.data['user']['email'],
        phone: response.data['user']['phone'],
        image: response.data['user']['image'],
      );
      await CashHelper.setUserData(user);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DriverHomeLayout(),
        ),
      );
      // }
    } catch (error) {
      if (error is DioException) {
        otpError = true;
      } else {
        print("An unexpected error occurred: $error");
      }
      Navigator.pop(context);
      notifyListeners();
    }
    });
  }

  // Future<void> verifierOtp(RegisterModel data, BuildContext context,
  //     Function Forword, int otp) async {
  //   // Clear previous errors
  //   otpError = false;
  //   notifyListeners();
  //   otpLoading(context);
  //   await requestNotificationPermission(context).then((value) async {
  //     try {
  //       final response = await DioHelper.postData(
  //         withToken: false,
  //         url: 'verify-otp',
  //         data: {"user_id": data.userId, "otp": otp, "fcm_token": value},
  //       );
  //       print(response.data['token']);
  //       print(response.data);
  //
  //       loading = false;
  //       notifyListeners();
  //       Navigator.pop(context);
  //       if (response.data['redirect_to'] == '/update-profile') {
  //         data.token = response.data['token'];
  //         Forword();
  //       } else {
  //         await SecureCashHelper.setToken(response.data['token']);
  //         await CashHelper.setUserId(data.userId!);
  //         UserModel user = UserModel(
  //           fullName: response.data['user']['fullname'],
  //           email: response.data['user']['email'],
  //           phone: response.data['user']['phone'],
  //           image: response.data['user']['image'],
  //         );
  //         await CashHelper.setUserData(user);
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const UserHomeLayout(),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       if (error is DioException) {
  //         otpError = true;
  //       } else {
  //         print("An unexpected error occurred: $error");
  //       }
  //       Navigator.pop(context);
  //       notifyListeners();
  //     }
  //   });
  // }

  Future<void> UpdateProfile(
      RegisterModel data, BuildContext context, Function Forword) async {
    // Clear previous errors
    errors = {};
    loading = true;
    notifyListeners();

    try {
      final response = await DioHelper.postData(
          withToken: false,
          url: 'update-user-info',
          data: {
            "user_id": data.userId,
            "fullname": data.fullName,
            "email": data.email
          });
      print(response);
      await SecureCashHelper.setToken(data.token);
      await CashHelper.setUserId(data.userId!);
      UserModel user = UserModel(
        fullName: response.data['user']['fullname'],
        email: response.data['user']['email'],
        phone: response.data['user']['phone'],
        image: response.data['user']['image'],
      );
      await CashHelper.setUserData(user);

      loading = false;
      notifyListeners();
      Forword();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => SecondLoginScreen(),),);
    } catch (error) {
      if (error is DioException) {
        errors = error.response?.data['errors'] ?? {};
      } else {
        print("An unexpected error occurred: $error");
      }
      loading = false;
      notifyListeners();
    }
  }

  void otpLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          content: Container(
              margin: EdgeInsets.symmetric(horizontal: 80, vertical: 80),
              color: Colors.transparent,
              child: IconLoader()),
        );
      },
    );
  }

  Future<void> updateFullName({
    required BuildContext context,
    required String fullName,
  }) async {
    // Clear previous errors

    loading = true;
    notifyListeners();

    try {
      final response = await DioHelper.postData(
          url: 'drivers/update-fullname', data: {"fullname": fullName});
      print(response.data['driver']);

      UserModel user = UserModel(
        fullName: response.data['driver']['fullname'],
        phone: response.data['driver']['phone'],
      );
      await CashHelper.setUserData(user);

      loading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (error) {
      print(error);
      if (error is DioException) {
        errors = error.response?.data['errors'] ?? {};
      } else {
        print("An unexpected error occurred: $error");
      }
      loading = false;
      notifyListeners();
    }
  }

  Future<void> updatePhoneNumber({
    required BuildContext context,
    required String phone,
  }) async {
    // Clear previous errors

    loading = true;
    notifyListeners();

    try {
      final response = await DioHelper.postData(
          url: 'drivers/update-phone', data: {'phone': phone});
      print(response.data['driver']);

      UserModel user = UserModel(
        fullName: response.data['driver']['name'],
        phone: response.data['driver']['phone'],
      );
      await CashHelper.setUserData(user);
      loading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (error) {
      print(error);
      if (error is DioException) {
        errors = error.response?.data['errors'] ?? {};
      } else {
        print("An unexpected error occurred: $error");
      }
      loading = false;
      notifyListeners();
    }
  }

  Future<String?> handleNotificationPermission(BuildContext context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Check if running on iOS simulator
    if (Platform.isIOS) {
      try {
        // Try to get APNS token first on iOS
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) {
          // Running on simulator or APNS not available
          print('APNS token not available (likely running on simulator)');
          return null; // Return null to proceed without FCM token
        }
      } catch (e) {
        print('Error getting APNS token: $e');
        return null;
      }
    }

    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      try {
        // Permission granted, get token
        return await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print('Error getting FCM token: $e');
        return null;
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      // Permission denied, prompt user to enable it in settings
      bool? shouldOpenSettings = await showPermissionAlert(context);

      if (shouldOpenSettings == true) {
        openAppSettings();
        return await waitForPermission(context);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
Future<bool?> showPermissionAlert(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Notification Permission Required"),
        content: const Text(
            "This feature requires notification permission. Please enable it in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Deny
            child: const Text("Continue without"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Open settings
            child: const Text("Open Settings"),
          ),
        ],
      );
    },
  );
}

Future<String?> waitForPermission(BuildContext context) async {
  await Future.delayed(
      const Duration(seconds: 2)); // Give time for navigation

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    return await FirebaseMessaging.instance.getToken();
  } else {
    return null; // Proceed without FCM token
  }
}
}
