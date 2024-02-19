import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hue_dada/light/model/light.dart';

class Room extends Equatable {
  const Room({
    required this.id,
    required this.name,
    required this.icon,
    this.isOn = false,
    this.brightness = 100,
    this.lights = const [],
  });

  factory Room.fromFirebase(String id, Map<String, dynamic> data) {
    return Room(
      id: id,
      name: data['name'],
      icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
      isOn: data['isOn'],
      brightness: data['brightness'],
    );
  }

  final String id;
  final String name;
  final IconData icon;
  final bool isOn;
  final int brightness;
  final List<Light> lights;

  bool hasLightsOnAfterChange(String lightId, bool isOn) {
    final newLights = lights
        .map((l) => l.id == lightId ? l.copyWith(isOn: isOn) : l)
        .toList();
    return newLights.any((l) => l.isOn);
  }

  bool get canSwitchLightState => lights.isNotEmpty;

  bool get canChangeBrightness =>
      lights.isNotEmpty && lights.any((l) => l.isOn);

  Room copyWith({
    String? id,
    String? name,
    IconData? icon,
    bool? isOn,
    int? brightness,
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

  @override
  List<Object?> get props => [
        id,
        name,
        icon,
        isOn,
        brightness,
        lights,
      ];
}
