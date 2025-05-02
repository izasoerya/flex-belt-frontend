import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final bool on;
  final void Function(bool)? onChanged;

  const SwitchButton({super.key, required this.on, required this.onChanged});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.on;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: _isOn,
        activeColor: Colors.red,
        onChanged: (bool d) => setState(() {
              _isOn = d;
              widget.onChanged!(_isOn);
            }));
  }
}
