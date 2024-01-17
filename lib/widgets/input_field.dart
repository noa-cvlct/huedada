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
  });

  final String? label;
  final String? hint;
  final String? error;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFd9d9d9),
                offset: Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-5, -5),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextField(
            keyboardType: keyboardType,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48),
                borderSide: BorderSide.none,
              ),
              labelText: label,
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              suffixIcon: suffixIcon,
              suffixIconColor: Colors.grey,
            ),
            onChanged: onChanged,
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Text(
              error!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
