import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/core/models/notification_model.dart';
import 'package:pills_reminder/core/models/notification_type.dart';
import 'package:pills_reminder/core/models/weekday.dart';
import 'package:pills_reminder/features/notifications/domain/repositories/notification_repo.dart';

class NotificationsController extends GetxController {
  final NotificationRepo notificationRepo;
  NotificationsController(this.notificationRepo);

  @override
  void onInit() async {
    super.onInit();
    await notificationRepo.initNotificationService();
  }

  Future<void> requestNotificationPermission() async {
    await notificationRepo.requestNotificationPermission();
  }

  Future<void> cancelNotification(int id) async {
    await notificationRepo.cancelNotification(id);
  }

  Future<void> cancelAllNotificationForMedication(int id) async {
    await notificationRepo.cancelAllNotificationForMedication(id);
  }

  Future<void> normalNotification({
    required String title,
    required String body,
  }) async {
    notificationRepo.normalNotification(title: title, body: body);
  }

  Future<void> scheduleNotification({
    required DateTime dateTime,
    required int id,
    String? title,
    String? body,
    required String medicationName,
    NotificationType? notificationType,
    bool isRepeating = false,
  }) async {
    notificationRepo.scheduleNotification(
      dateTime: dateTime,
      id: id,
      title: title,
      body: body,
      medicationName: medicationName,
      notificationType: notificationType,
      isRepeating: isRepeating,
    );
  }

  Future<void> scheduleDailyOrWeeklyNotification({
    required int id,
    String? title,
    String? body,
    required String medicationName,
    required TimeOfDay time,
    required List<Weekday> weekdays,
    NotificationType? notificationType,
  }) async {
    notificationRepo.scheduleDailyOrWeeklyNotification(
      id: id,
      title: title,
      body: body,
      medicationName: medicationName,
      time: time,
      weekdays: weekdays,
      notificationType: notificationType,
    );
  }

  Future<void> rescheduleNotification({
    required NotificationModel notification,
  }) async {
    notificationRepo.rescheduleNotification(notification: notification);
  }

  Future<void> rescheduleMedicationsNotifications({required int id}) async {
    notificationRepo.rescheduleMedicationsNotifications(id: id);
  }

  Future<void> rescheduleAllNotifications() async {
    notificationRepo.rescheduleAllNotifications();
  }
}
