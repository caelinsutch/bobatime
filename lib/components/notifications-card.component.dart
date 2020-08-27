import 'package:flutter/material.dart';

enum NotificationLevel { alert, info }

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final NotificationLevel notificationLevel;

  NotificationCard({
    @required this.title,
    @required this.body,
    this.notificationLevel = NotificationLevel.info,
  });
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
