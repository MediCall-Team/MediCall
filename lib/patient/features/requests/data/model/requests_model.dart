import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PRequestsModel {
  final int pageIndex;
  final int pageSize;
  final int count;
  final List<PRequestData> data;

  PRequestsModel({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  factory PRequestsModel.fromJson(Map<String, dynamic> json) {
    return PRequestsModel(
      pageIndex: json['pageIndex'],
      pageSize: json['pageSize'],
      count: json['count'],
      data: List<PRequestData>.from(
        json['data'].map((x) => PRequestData.fromJson(x)),
      ),
    );
  }
}



class PRequestData {
  final int id;
  final String description;
  final double longitude;
  final double latitude;
  final String date;
  final String time;
  final String providerName;
  final String providerPictureUrl;
  final String specialization;
  final String statusName;

  PRequestData({
    required this.id,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.date,
    required this.time,
    required this.providerName,
    required this.providerPictureUrl,
    required this.specialization,
    required this.statusName,
  });

  factory PRequestData.fromJson(Map<String, dynamic> json) {
    return PRequestData(
      id: json['id'],
      description: json['description'] ?? '',
      longitude: (json['longitude'] ?? 0).toDouble(),
      latitude: (json['latitude'] ?? 0).toDouble(),
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      providerName: json['providerName'] ?? '',
      providerPictureUrl: json['providerPictureUrl'] ?? '',
      specialization: json['specialization'] ?? '',
      statusName: json['statusName'] ?? '',
    );
  }

  /// تحويل التاريخ إلى DateTime
  DateTime get dateTime {
    return DateTime.parse(date);
  }

  /// تحويل الوقت إلى TimeOfDay
  TimeOfDay get timeOfDay {
  // تنظيف النص
  final cleanTime = time.trim();
  
  // استخراج الساعات والدقائق وAM/PM
  final parts = cleanTime.split(RegExp(r'[: ]'));
  
  if (parts.length >= 3) {
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    String period = parts[2].toUpperCase();
    
    if (period == 'PM' && hour != 12) {
      hour += 12;
    }
    if (period == 'AM' && hour == 12) {
      hour = 0;
    }
    
    return TimeOfDay(hour: hour, minute: minute);
  }
  
  // fallback
  return TimeOfDay.now();
}

DateTime get scheduledDateTime {
  final timeOfDay = this.timeOfDay;
  
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}
}