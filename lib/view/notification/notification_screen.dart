import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/providers/notification_provider.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import 'package:provider/provider.dart';
import '../../../shared/components/cards/notification_card.dart';
import '../../../utils/colors.dart';
import '../../shared/components/header/driver_header.dart';
import '../../shared/error/error_component.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
   return Consumer<NotificationProvider>(
      builder: (context,notificationProvider,child){
        return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  driverHeader(
                      text: context.translate('bottomBar.notification'),
                      context: context),
                  Expanded(
                    child: FutureBuilder(
                        future: notificationProvider.getNotification(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.error == 'Failed to load data') {
                            return Center(
                              child: noOrders(context: context),
                            );
                          }
                    
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            if (snapshot.error == 'connection timeout') {
                              return const Center(
                                // child: ConnectionProbleme(
                                //     context: context,
                                //     pressed: () {
                                //       setState(() {
                                //         _refreshData = true;
                                //       });
                                //     }),
                              );
                            } else {
                              return Center(child: undefinedError(context: context));
                            }
                          } else {
                            final notifications = snapshot.data;
                    
                            return   ListView.separated(
                              // padding: EdgeInsets.only(bottom: 20),
                                itemBuilder: (context, index) {
                                  return NotificationCard(
                                    notification: notifications[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: BorderColor.grey5,
                                  );
                                },
                                itemCount: notifications!.length);
                          }
                        }),
                  )
                ],
              )),
        );
      },
    );
  }
}
