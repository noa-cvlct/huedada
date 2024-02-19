import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.label,
    this.hint,
    this.error,
    this.obscureText,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
  });

  final String? label;
  final String? hint;
  final String? error;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(48),
      ),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48),
            borderSide: BorderSide.none,
          ),
          error: error == null
              ? null
              : Text(
                  error!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.grey,
        ),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
