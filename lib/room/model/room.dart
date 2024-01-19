import 'package:flutter/material.dart';

class Room {
  const Room({
    required this.id,
    required this.name,
    required this.icon,
    this.isOn = false,
    this.brightness = 100,
  });

  factory Room.fromFirebase(String id, Map<String, dynamic> data) {
    return Room(
      id: id,
      name: data['name'],
      icon: IconData(data['icon']),
      isOn: data['isOn'],
      brightness: data['brightness'],
    );
  }

  final String id;
  final String name;
  final IconData icon;
  final bool isOn;
  final double brightness;

  Room copyWith({
    String? id,
    String? name,
    IconData? icon,
    bool? isOn,
    double? brightness,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isOn: isOn ?? this.isOn,
      brightness: brightness ?? this.brightness,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'isOn': isOn,
      'brightness': brightness,
    };
  }
}
