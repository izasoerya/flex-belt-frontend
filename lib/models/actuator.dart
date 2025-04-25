import 'dart:convert';

class Actuator {
  final int heater;
  final bool isCold;

  const Actuator({
    required this.heater,
    required this.isCold,
  });

  factory Actuator.fromJson(Map<String, dynamic> json) {
    return Actuator(
      heater: json['heater']?.toInt() ?? 0,
      isCold: json['isCold'] ?? false,
    );
  }

  factory Actuator.fromString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Actuator(
      heater: json['heater']?.toInt() ?? 0,
      isCold: json['isCold'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heater': heater,
      'isCold': isCold,
    };
  }
}
