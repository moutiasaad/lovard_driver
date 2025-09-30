// import 'package:flutter/cupertino.dart';
// import 'package:gift_delivery_app/shared/local/cash_helper.dart';
// import '../shared/local/secure_cash_helper.dart';
// import '../shared/remote/dio_helper.dart';
//
// class AuthProvider extends ChangeNotifier {
//   Future<void> checkToken(BuildContext context) async {
//     int? userId = CashHelper.getUserId();
//     print(userId);
//     try {
//       String token = await SecureCashHelper.getToken();
//       if (token.isEmpty || (userId.toString().isEmpty || userId == null)) {
//         CashHelper.clearData();
//       } else {
//         final response = await DioHelper.postData(
//           withToken: false,
//           url: 'check-token',
//           data: {
//             "userId": userId.toString(),
//             "token": token,
//           },
//         );
//         print(response);
//         SecureCashHelper.setToken(response.data['token'] ?? "");
//         if (response.data['is_valid'] == false) {
//           CashHelper.clearData();
//         }
//       }
//     } catch (error) {
//       CashHelper.clearData();
//     }
//   }
// }
