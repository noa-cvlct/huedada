import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.color = Colors.white,
    required this.backgroundGradient,
    this.innerPadding,
    this.onPressed,
    this.child,
  });

  final Color color;
  final Gradient backgroundGradient;
  final EdgeInsets? innerPadding;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        gradient: backgroundGradient,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: color,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
          padding: innerPadding,
          minimumSize: const Size.fromHeight(48),
        ),
        child: child,
      ),
    );
  }
}
