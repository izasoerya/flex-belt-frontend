import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double value = widget.value;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2.5,
        activeTrackColor: const Color.fromRGBO(2, 84, 100, 1),
        inactiveTrackColor: Colors.grey.shade400,
        thumbColor: Colors.white,
        valueIndicatorColor: Theme.of(context).textTheme.bodyLarge?.color,
        showValueIndicator: ShowValueIndicator.always,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 22.5, bottom: 7.5),
        child: Slider(
          value: value,
          onChanged: (newValue) {
            setState(() => value = newValue);
            widget.onChanged(value);
          },
          min: widget.min,
          max: widget.max,
          label: value.toStringAsFixed(0),
        ),
      ),
    );
  }
}
