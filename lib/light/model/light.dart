import 'package:flutter/material.dart';

class Light {
  const Light({
    required this.id,
    required this.name,
    required this.icon,
    this.isOn = false,
    this.color = Colors.white,
    this.brightness = 100,
  });

  factory Light.fromFirebase(String id, Map<String, dynamic> data) {
    return Light(
      id: id,
      name: data['name'],
      icon: IconData(data['icon']),
      isOn: data['isOn'],
      color: Color(data['color']),
      brightness: data['brightness'],
    );
  }

  final String id;
  final String name;
  final IconData icon;
  final bool isOn;
  final Color color;
  final double brightness;

  Light copyWith({
    String? id,
    String? name,
    IconData? icon,
    bool? isOn,
    Color? color,
    double? brightness,
  }) {
    return Light(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isOn: isOn ?? this.isOn,
      color: color ?? this.color,
      brightness: brightness ?? this.brightness,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'isOn': isOn,
      'color': color.value,
      'brightness': brightness,
    };
  }
}
