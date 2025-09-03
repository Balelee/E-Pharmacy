import 'package:intl/intl.dart';

class OpeningHour {
  final String day;
  final String openingTime;
  final String closingTime;

  OpeningHour({
    required this.day,
    required this.openingTime,
    required this.closingTime,
  });

  factory OpeningHour.fromJson(Map<String, dynamic> json) {
    return OpeningHour(
      day: json['day'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
    );
  }
}

class Pharmacy {
  final int? id;
  final String? pharmacienId;
  final String? name;
  final String? adresse;
  final String? phone;
  final int? isOnDuty;
  final bool? isOpenNow;
  final String? latitude;
  final String? longitude;
  final List<OpeningHour>? openingHours;

  Pharmacy({
    this.id,
    this.pharmacienId,
    this.name,
    this.adresse,
    this.phone,
    this.isOnDuty,
    this.isOpenNow,
    this.latitude,
    this.longitude,
    this.openingHours,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    var list = json['opening_hours'] as List;
    List<OpeningHour> hoursList =
        list.map((i) => OpeningHour.fromJson(i)).toList();

    return Pharmacy(
      id: json['id'],
      pharmacienId: json['pharmacien_id'].toString(),
      name: json['name'],
      adresse: json['adresse'],
      phone: json['phone'],
      isOnDuty: json['is_on_duty'],
      isOpenNow: json['is_open_now'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      openingHours: hoursList,
    );
  }

  OpeningHour? getOpeningHoursForToday() {
    final currentDay = DateFormat('EEEE', 'fr_FR').format(DateTime.now());
    try {
      return openingHours?.firstWhere(
        (hours) => hours.day.toLowerCase() == currentDay.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pharmacien_id': pharmacienId,
      'name': name,
      'adresse': adresse,
      'phone': phone,
      'is_on_duty': isOnDuty,
      'is_open_now': isOpenNow,
      'latitude': latitude,
      'longitude': longitude,
      'opening_hours': openingHours
          ?.map((oh) => {
                'day': oh.day,
                'opening_time': oh.openingTime,
                'closing_time': oh.closingTime,
              })
          .toList(),
    };
  }
}
