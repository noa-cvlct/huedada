import 'package:flutter/material.dart';
import 'package:hue_dada/theme.dart';

class RoomIcon extends StatelessWidget {
  const RoomIcon({
    super.key,
    required this.label,
    required this.iconData,
    required this.onPressed,
  });

  final String label;
  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 90,
      child: Column(
        children: [
          IconButton(
            onPressed: onPressed,
            color: Colors.white,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(lightGrey),
            ),
            icon: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
