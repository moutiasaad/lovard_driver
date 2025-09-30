import 'package:lovard_delivery_app/providers/notification_provider.dart';
import 'package:lovard_delivery_app/providers/order_provider.dart';
import 'package:lovard_delivery_app/providers/profile_provider.dart';
import 'package:lovard_delivery_app/providers/register_provider.dart';
import 'package:lovard_delivery_app/providers/wallet_provide.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../shared/language/language_provider.dart';

class ProviderConfig {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
    ),
    ChangeNotifierProvider<RegisterProvider>(
      create: (_) => RegisterProvider(),
    ),
    ChangeNotifierProvider<OrderProvider>(
      create: (_) => OrderProvider(),
    ),
    ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider(),
    ),
    ChangeNotifierProvider<WalletProvider>(
      create: (_) => WalletProvider(),
    ),
    ChangeNotifierProvider<NotificationProvider>(
      create: (_) => NotificationProvider(),
    ),

  ];
}
