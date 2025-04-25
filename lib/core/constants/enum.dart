import 'dart:ui';

enum StatusType {
  dangerous,
  caution,
  safe,
}

extension StatusTypeExtension on StatusType {
  static StatusType fromString(String status) {
    switch (status) {
      case 'dangerous':
        return StatusType.dangerous;
      case 'caution':
        return StatusType.caution;
      case 'safe':
        return StatusType.safe;
      default:
        throw Exception('Invalid status type: $status');
    }
  }

  Color getColor() {
    switch (this) {
      case StatusType.dangerous:
        return const Color.fromRGBO(255, 0, 0, 1);
      case StatusType.caution:
        return const Color.fromRGBO(255, 165, 0, 1);
      case StatusType.safe:
        return const Color.fromARGB(255, 0, 189, 0);
    }
  }
}
