import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Light extends Equatable {
  const Light({
    required this.id,
    required this.name,
    required this.icon,
    this.isOn = false,
    this.color = Colors.white,
    this.brightness = 100,
    this.syncWithSound = false,
    required this.type,
  });

  factory Light.fromFirebase(String id, Map<String, dynamic> data) {
    return Light(
      id: id,
      name: data['name'],
      icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
      isOn: data['isOn'],
      color: Color(data['color']),
      brightness: data['brightness'],
      syncWithSound: data['syncWithSound'],
      type: LightType.fromFirebase(data['type']),
    );
  }

  final String id;
  final String name;
  final IconData icon;
  final bool isOn;
  final Color color;
  final int brightness;
  final bool syncWithSound;
  final LightType type;

  Light copyWith({
    String? id,
    String? name,
    IconData? icon,
    bool? isOn,
    Color? color,
    int? brightness,
    bool? syncWithSound,
    LightType? type,
  }) {
    return Light(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isOn: isOn ?? this.isOn,
      color: color ?? this.color,
      brightness: brightness ?? this.brightness,
      syncWithSound: syncWithSound ?? this.syncWithSound,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'isOn': isOn,
      'color': color.value,
      'brightness': brightness,
      'syncWithSound': syncWithSound,
      'type': type.toFirebase(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        icon,
        isOn,
        color,
        brightness,
        syncWithSound,
        type,
      ];
}

enum LightType {
  light,
  ledBar;

  factory LightType.fromFirebase(String type) {
    switch (type) {
      case 'ledBar':
        return LightType.ledBar;
      default:
        return LightType.light;
    }
  }

  String toFirebase() {
    return name;
  }
}
