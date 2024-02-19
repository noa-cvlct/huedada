part of 'create_light_cubit.dart';

class CreateLightState extends Equatable {
  const CreateLightState({
    required this.roomId,
    this.name = '',
    this.icon,
    this.type,
    this.status = CreateLightStateStatus.initial,
  });

  final String roomId;

  final String name;
  final IconData? icon;
  final LightType? type;
  final CreateLightStateStatus status;

  CreateLightState copyWith({
    String? name,
    IconData? icon,
    LightType? type,
    CreateLightStateStatus? status,
  }) {
    return CreateLightState(
      roomId: roomId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        roomId,
        name,
        icon,
        status,
      ];
}

enum CreateLightStateStatus {
  initial,
  selectedIcon,
  enteringName,
  selectedName,
  savingLight,
  lightSaved,
}
