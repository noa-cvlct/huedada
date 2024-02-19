import 'package:equatable/equatable.dart';
import 'package:hue_dada/room/model/room.dart';

class Home extends Equatable {
  const Home({
    required this.name,
    this.isOn = false,
    this.rooms = const [],
  });

  factory Home.fromFirebase(String id, Map<String, dynamic> data) {
    return Home(
      name: data['name'] as String,
      isOn: data['isOn'] as bool,
    );
  }

  final String name;
  final bool isOn;
  final List<Room> rooms;

  bool hasRoomsOnAfterChange(Room room, bool isOn) {
    final newRooms =
        rooms.map((r) => r.id == room.id ? r.copyWith(isOn: isOn) : r).toList();
    return newRooms.any((r) => r.isOn);
  }

  Home copyWith({
    String? name,
    bool? isOn,
    List<Room>? rooms,
  }) {
    return Home(
      name: name ?? this.name,
      isOn: isOn ?? this.isOn,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'isOn': isOn,
    };
  }

  @override
  List<Object?> get props => [
        name,
        isOn,
        rooms,
      ];
}
