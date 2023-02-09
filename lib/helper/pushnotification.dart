import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  Future<void> getToken(String uid) async {
    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await fcm.getToken();
    print("Token: $token");
    try {
      final tokenRef = FirebaseFirestore.instance.collection("users").doc(uid);

      tokenRef.update({"token": token});
    } catch (error) {
      print(error);
    }
  }
}
