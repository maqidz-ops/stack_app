import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../model/users_model.dart';
import '../utils/local_storage.dart';
import '../utils/notification.dart';

class AuthController {
  Future<Users?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://6a43cfa66dba791499ab71bb.mockapi.io/users?email=$email&password=$password",
        ),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          final user = Users.fromJson(data.first);

          // Storage
          await saveRole();

          // Local Notification
          if (!kIsWeb) {
            await NotificationService.initialize();
            await NotificationService.requestPermission();

            await NotificationService.plugin.show(
              id: 0,
              title: 'Login Success',
              body: 'You are now logged in.',
              notificationDetails: const NotificationDetails(
                android: AndroidNotificationDetails(
                  'basic_channel',
                  'Basic Notifications',
                  channelDescription: 'Notifications for login events',
                  importance: Importance.max,
                  priority: Priority.high,
                ),
              ),
            );
          }

          return user;
        }
      }

      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}