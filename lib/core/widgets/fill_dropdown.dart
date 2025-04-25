import 'package:flutter/material.dart';

class FillDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final void Function(String)? onChanged;

  const FillDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: items.contains(value) ? value : null,
            isDense: true,
            isExpanded: true,
            hint: Text(
              'Select Bluetooth Device',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            items: items.map((String device) {
              return DropdownMenuItem<String>(
                value: device,
                child: Text(
                  device,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue == null) return;
              onChanged?.call(newValue);
            },
          ),
        ),
      ),
    );
  }
}
