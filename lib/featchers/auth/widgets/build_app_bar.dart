import 'package:e_commerce/core/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

/// Builds the AppBar for the LoginView.
AppBar buildAppBar(
  BuildContext context, {
  required String title,
  bool showBackButton = true,
  bool showNotification = true,
}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    elevation: 0,
    actions: showNotification
        ? const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: NotificationWidget(),
            ),
          ]
        : null,
    leading: showBackButton
        ? IconButton(
            icon: SizedBox(
              width: 7.097500324249268,
              height: 15.84000015258789,
              child: const Icon(Icons.arrow_back_ios_new),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : null,
  );
}
