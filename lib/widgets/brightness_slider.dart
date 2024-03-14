import 'package:flutter/material.dart';
import 'package:hue_dada/theme.dart';

class BrightnessSlider extends StatelessWidget {
  const BrightnessSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return onChanged == null
        ? Container(
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(32),
            ),
            margin: const EdgeInsets.all(20),
            height: 8,
          )
        : Slider(
            label: value.round().toString(),
            value: value.toDouble(),
            onChanged: onChanged,
            min: 0,
            max: 100,
            divisions: 100,
            thumbColor: Colors.white,
            activeColor: Colors.white,
            inactiveColor: lightGrey,
          );
  }
}
