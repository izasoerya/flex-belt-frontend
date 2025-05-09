import 'package:flex_belt/core/widgets/boxed_icon.dart';
import 'package:flex_belt/core/widgets/fill_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PairDiv extends StatelessWidget {
  final List<BluetoothDevice> items;
  final BluetoothDevice? selectedDevice;
  final void Function(BluetoothDevice)? onChanged;
  final void Function()? onDisconnect;

  const PairDiv({
    super.key,
    required this.items,
    this.onChanged,
    this.selectedDevice,
    this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final itemNames = items
        .where((device) => device.name != null)
        .map((device) => device.name!)
        .toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(2, 84, 100, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pair your device',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 10),
              FillDropdown(
                items: itemNames,
                value: selectedDevice?.name,
                onChanged: (String newValue) {
                  final device = items.firstWhere((d) => d.name == newValue);
                  onChanged?.call(device);
                },
              ),
            ],
          ),
          BoxedIcon(
            icon: Icons.refresh_rounded,
            onTap: onDisconnect,
          ),
        ],
      ),
    );
  }
}
