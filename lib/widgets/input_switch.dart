import 'package:flutter/material.dart';
import 'package:hue_dada/theme.dart';

class InputSwitch extends StatelessWidget {
  const InputSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: MaterialStateProperty.all(
        onChanged == null
            ? lightGrey
            : value
                ? darkGrey
                : Colors.white,
      ),
      trackColor: MaterialStateProperty.all(
        onChanged == null
            ? darkGrey
            : value
                ? Colors.white
                : darkGrey,
      ),
      trackOutlineColor: MaterialStateProperty.all(
        onChanged == null ? lightGrey : Colors.white,
      ),
    );
  }
}
