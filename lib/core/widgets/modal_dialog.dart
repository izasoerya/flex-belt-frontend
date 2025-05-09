import 'package:flutter/material.dart';

class ModalDialog extends StatelessWidget {
  final void Function(bool) callback; // you can remove this if unused

  const ModalDialog({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Do you want to set heater this high?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false); // Cancel
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true); // Confirm
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
