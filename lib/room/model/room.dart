import 'package:flutter/material.dart';
import 'package:hue_dada/light/model/light.dart';

class Room {
  const Room({
    required this.id,
    required this.name,
    required this.icon,
    this.isOn = false,
    this.brightness = 100,
    this.lights,
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
  final List<Light>? lights;

  Room copyWith({
    String? id,
    String? name,
    IconData? icon,
    bool? isOn,
    double? brightness,
    List<Light>? lights,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isOn: isOn ?? this.isOn,
      brightness: brightness ?? this.brightness,
      lights: lights ?? this.lights,
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
