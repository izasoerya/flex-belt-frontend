import 'dart:async';
import 'dart:convert';

import 'package:flex_belt/models/actuator.dart';
import 'package:flex_belt/models/payload.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothClient {
  BluetoothClient();

  late BluetoothConnection _connection;

  static Future<List<BluetoothDevice>> getBondedDevices() async {
    try {
      return await FlutterBluetoothSerial.instance.getBondedDevices();
    } on PlatformException catch (e) {
      throw Exception('Error getting bonded devices: $e');
    }
  }

  Future<void> connect(String address) async {
    try {
      _connection = await BluetoothConnection.toAddress(address);
    } catch (e) {
      throw Exception('Error connecting to device: $e');
    }
  }

  Future<StreamSubscription<Uint8List>> listen(
      void Function(Payload) onStream) async {
    if (_connection.isConnected) {
      return _connection.input!.listen((data) {
        final rawData = String.fromCharCodes(data);
        if (rawData.contains('}') && rawData.contains('{')) {
          final startIndex = rawData.indexOf('{');
          final endIndex = rawData.indexOf('}') + 1;

          final jsonString = rawData.substring(startIndex, endIndex);
          onStream(Payload.fromString(jsonString));
        }
      });
    } else {
      throw Exception('Not connected to the device');
    }
  }

  Future<void> send(Actuator data) async {
    if (_connection.isConnected) {
      try {
        final json = '${jsonEncode(data.toJson())}\n';
        _connection.output.add(Uint8List.fromList(json.codeUnits));
        await _connection.output.allSent;
        print('Data sent: $json');
      } catch (e) {
        throw Exception('Error sending data: $e');
      }
    } else {
      throw Exception('Not connected to the device');
    }
  }

  Future<void> disconnect() async {
    if (_connection.isConnected) {
      await _connection.close();
    } else {
      throw Exception('Not connected to the device');
    }
  }
}
