import 'package:flex_belt/core/constants/enum.dart';
import 'package:flex_belt/core/widgets/control_div.dart';
import 'package:flex_belt/core/widgets/notification.dart';
import 'package:flex_belt/core/widgets/pair_div.dart';
import 'package:flex_belt/core/widgets/payload_list.dart';
import 'package:flex_belt/core/widgets/toggle_container.dart';
import 'package:flex_belt/models/actuator.dart';
import 'package:flex_belt/services/bluetooth_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late BluetoothClient bluetoothClient;
  BluetoothDevice? selectedDevice;

  final GlobalKey<PayloadListState> _listKey = GlobalKey<PayloadListState>();
  final GlobalKey<ToggleContainerState> _updateKey =
      GlobalKey<ToggleContainerState>();

  Future<BluetoothClient> connectToDevice(String address) async {
    bluetoothClient = BluetoothClient();
    await bluetoothClient.connect(address);
    return bluetoothClient;
  }

  void _callbackDropdown(BluetoothDevice device) {
    setState(() => selectedDevice = device);
  }

  Map<bool, int> heaterValues = {true: 50};
  void _callbackToggle(Map<bool, int> values) {
    heaterValues = values;
    print(values);
    (bluetoothClient.send(
      Actuator(
        heater: heaterValues.values.first,
        isCold: heaterValues.keys.first,
      ),
    ));
  }

  void _disconnectCMD() {
    bluetoothClient.disconnect().then((_) {
      setState(() => selectedDevice = null);
      _listKey.currentState?.clear();
    }).catchError((error) {
      print('Error disconnecting: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FutureBuilder(
            future: BluetoothClient.getBondedDevices(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                return const Center(child: Text('No devices found'));
              }

              return PairDiv(
                items: snapshot.data as List<BluetoothDevice>,
                selectedDevice: selectedDevice,
                onChanged: _callbackDropdown,
                onDisconnect: _disconnectCMD,
              );
            },
          ),
          selectedDevice == null
              ? SizedBox()
              : FutureBuilder(
                  future: connectToDevice(selectedDevice!.address),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() => selectedDevice = null);
                      });
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final ValueNotifier<StatusType> statusNotifier =
                          ValueNotifier(StatusType.safe);
                      bluetoothClient.listen((payload) {
                        if (payload.status == StatusType.caution ||
                            payload.status == StatusType.dangerous) {
                          NotificationModal.instance.showNotification(
                            payload.status.name,
                            payload.description,
                          );
                          payload = payload;
                        }
                        statusNotifier.value = payload.status;
                        _listKey.currentState?.addPayload(payload);
                        _updateKey.currentState?.updatePayload(payload);
                      });
                      return Column(
                        children: [
                          ToggleContainer(
                            key: _updateKey,
                            onPressed: () => bluetoothClient.send(
                              Actuator(
                                heater: -1,
                                isCold: true,
                                resetEncoder: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ControlDiv(
                            statusNotifier: statusNotifier,
                            heaterValues: _callbackToggle,
                          ),
                        ],
                      );
                    }
                  },
                ),
          const SizedBox(height: 20.0),
          PayloadList(key: _listKey),
        ],
      ),
    );
  }
}
