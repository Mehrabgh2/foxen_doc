import 'package:flutter/material.dart';
import '../../../model/response/notification_response.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    required this.notification,
    super.key,
  });
  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Text(notification.message ?? ''),
    );
  }
}
