import 'dart:convert';

class Actuator {
  final int heater;
  final bool isCold;
  final bool resetEncoder;

  const Actuator({
    required this.heater,
    required this.isCold,
    this.resetEncoder = false,
  });

  factory Actuator.fromJson(Map<String, dynamic> json) {
    return Actuator(
      heater: json['heater']?.toInt() ?? 0,
      isCold: json['isCold'] ?? false,
      resetEncoder: json['resetEncoder'] ?? false,
    );
  }

  factory Actuator.fromString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Actuator(
      heater: json['heater']?.toInt() ?? 0,
      isCold: json['isCold'] ?? false,
      resetEncoder: json['resetEncoder'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heater': heater,
      'isCold': isCold,
      'resetEncoder': resetEncoder,
    };
  }
}
