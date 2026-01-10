import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class RemoteNotificationService {
  RemoteNotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // Request FCM permission
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final notification = message.notification!;
        LocalNotificationService().showNotification(
          id: message.messageId.hashCode,
          title: notification.title ?? 'Notification',
          body: notification.body ?? '',
        );
      }
    });
  }

  static Future<void> clearToken() async {
    await _messaging.deleteToken();
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}
