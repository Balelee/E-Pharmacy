import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationService._internal() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> initialize() async {
    tzData.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Ouagadougou'));
    const androidSettings = AndroidInitializationSettings('icon_tiim');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {},
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'rappel_product_alarm',
        'Rappels Médicaments',
        description: 'Notifications pour rappels de médicaments',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        // sound: RawResourceAndroidNotificationSound('custom_sound'),
      ),
    );
  }

  Future<void> requestPermission() async {
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      print(
          '✅ Permission notifications : ${granted == true ? "accordée" : "refusée"}');
    }
  }

  DateTime _adjustScheduledDate(DateTime date, String frequency) {
    final now = DateTime.now();
    if (!date.isAfter(now)) {
      if (frequency.toLowerCase().contains('quotidien')) {
        return date.add(const Duration(days: 1));
      } else if (frequency.toLowerCase().contains('hebdomadaire')) {
        return date.add(const Duration(days: 7));
      } else if (frequency.toLowerCase().contains('mensuel')) {
        int newMonth = date.month + 1;
        int newYear = date.year;
        if (newMonth > 12) {
          newMonth = 1;
          newYear += 1;
        }
        return DateTime(newYear, newMonth, date.day, date.hour, date.minute);
      }
      return date.add(const Duration(days: 1));
    }
    return date;
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String frequency,
  }) async {
    DateTime adjustedDate = _adjustScheduledDate(scheduledDate, frequency);
    if (adjustedDate.isBefore(DateTime.now().add(Duration(seconds: 10)))) {
      adjustedDate = DateTime.now().add(Duration(seconds: 10));
    }
    final localDateTime = adjustedDate.toLocal();
    final tzDateTime = tz.TZDateTime.from(localDateTime, tz.local);
    DateTimeComponents? repeatPattern;
    final freqLower = frequency.toLowerCase();
    if (freqLower.contains('quotidien')) {
      repeatPattern = DateTimeComponents.time;
    } else if (freqLower.contains('hebdomadaire')) {
      repeatPattern = DateTimeComponents.dayOfWeekAndTime;
    }
    final androidDetails = AndroidNotificationDetails(
      'rappel_product_alarm',
      'Rappels Médicaments',
      channelDescription: 'Notifications pour rappels de médicaments',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: 'icon_tiim',
      // sound: RawResourceAndroidNotificationSound('custom_sound'),
    );
    final notificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: repeatPattern,
      payload: 'medicament_$id',
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  print(
      '📱 Notification cliquée en arrière-plan (background) : ${response.payload}');
}
