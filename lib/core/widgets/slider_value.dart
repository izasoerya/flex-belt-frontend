import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;
  final double min;
  final double max;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onChangeEnd,
    this.min = 0.0,
    this.max = 100.0,
  });

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
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
          min: min,
          max: max,
          label: value.toStringAsFixed(0),
        ),
      ),
    );
  }
}
