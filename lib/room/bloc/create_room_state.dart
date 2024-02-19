part of 'create_room_cubit.dart';

class CreateRoomState extends Equatable {
  const CreateRoomState({
    this.name = '',
    this.icon,
    this.status = CreateRoomStateStatus.initial,
  });

  final String name;
  final IconData? icon;
  final CreateRoomStateStatus status;

  CreateRoomState copyWith({
    String? name,
    IconData? icon,
    CreateRoomStateStatus? status,
  }) {
    return CreateRoomState(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        name,
        icon,
        status,
      ];
}

enum CreateRoomStateStatus {
  initial,
  selectedIcon,
  enteringName,
  selectedName,
  savingRoom,
  roomSaved,
}
