import 'dart:convert';

import 'package:flex_belt/core/constants/enum.dart';

class Payload {
  final double angleX;
  final double angleY;
  final double angleZ;
  final int flex;
  final int encoder;
  final int battery;
  final String description;
  final StatusType status;
  final DateTime dateTime = DateTime.now();

  Payload({
    required this.angleX,
    required this.angleY,
    required this.angleZ,
    required this.flex,
    required this.encoder,
    required this.battery,
    required this.description,
    required this.status,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      angleX: json['angleX']?.toDouble() ?? 0.0,
      angleY: json['angleY']?.toDouble() ?? 0.0,
      angleZ: json['angleZ']?.toDouble() ?? 0.0,
      flex: json['flex']?.toInt() ?? 0,
      encoder: json['encoder']?.toInt() ?? 0,
      battery: json['battery']?.toInt() ?? 0,
      description: json['description'] ?? '',
      status: StatusTypeExtension.fromString(json['status'] ?? 'safe'),
    );
  }

  factory Payload.fromString(String jsonString) {
    if (jsonString.isEmpty) throw Exception('Payload is empty');
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Payload(
      angleX: json['angleX']?.toDouble() ?? 0.0,
      angleY: json['angleY']?.toDouble() ?? 0.0,
      angleZ: json['angleZ']?.toDouble() ?? 0.0,
      flex: json['flex']?.toInt() ?? 0,
      encoder: json['encoder']?.toInt() ?? 0,
      battery: json['battery']?.toInt() ?? 0,
      description: json['description'] ?? '',
      status: StatusTypeExtension.fromString(json['status'] ?? 'safe'),
    );
  }
}
