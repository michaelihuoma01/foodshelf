import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/notifications_controller.dart';
import 'package:foodshelf/models/notifications.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/notifications_tile.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class NotificationsTab extends StatefulWidget {
  static const routeName = '/NotificationsTab';

  @override
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends StateMVC<NotificationsTab> {
  NotificationsController _ctrl;

  _NotificationsTabState() : super(NotificationsController()) {
    _ctrl = controller;
  }

  FlutterSecureStorage storage = FlutterSecureStorage();
  String uuid;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) =>
                _ctrl = context.watch<NotificationsController>(),
          ),
        ],
        builder: (context, child) {
          _ctrl.getNotificationsList.addListener(
            () => Future.delayed(
              Duration(seconds: 1),
              () => setState(
                () {
                  _ctrl.fetchingAddresses = false;
                },
              ),
            ),
          );
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: Image.asset('assets/images/png/background.png').image,
              ),
            ),
            child: Scaffold(
              key: _ctrl.scaffoldKey,
              backgroundColor: Colors.transparent,
              body: (_ctrl.fetchingAddresses)
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 170),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Notifications',
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Bold')),
                              InkWell(
                                onTap: () async {
                                  uuid = await storage.read(key: 'uid');
                                  print(uuid);
                                  _ctrl.emptyNotifications(uuid);
                                },
                                child: Text('Clear notifications',
                                    style: TextStyle(
                                        color: BrandColors.colorAccent,
                                        fontFamily: 'Regular')),
                              ),
                            ],
                          ),
                          (_ctrl.getNotificationsList.value.length != 0)
                              ? Expanded(
                                  child: ListView(
                                      children: _ctrl?.getNotificationsList
                                                  ?.value !=
                                              null
                                          ? _ctrl.getNotificationsList.value
                                              .map(
                                                (NotificationsModel
                                                        notificationsModel) =>
                                                    Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    NotificationsTile(
                                                      title: notificationsModel
                                                          .description,
                                                      price: '49.99',
                                                      context: context,
                                                    ),
                                                    SizedBox(height: 20)
                                                  ],
                                                ),
                                              )
                                              .toList()
                                          : []),
                                )
                              : Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child:   Text('No Notifications'),
                              ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
