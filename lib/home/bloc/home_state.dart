part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.home,
    this.rooms = const [],
    this.status = HomeStateStatus.initial,
  });

  final Home? home;
  final List<Room> rooms;
  final HomeStateStatus status;

  HomeState copyWith({
    Home? home,
    List<Room>? rooms,
    HomeStateStatus? status,
    bool clearHome = false,
  }) {
    return HomeState(
      home: clearHome ? null : home ?? this.home,
      rooms: rooms ?? this.rooms,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        home,
        rooms,
        status,
      ];
}

enum HomeStateStatus {
  initial,
  listenedHomeChanges,
  homeLightStateUpdated,
  updatingHomeLightState,
  loading,
  success,
  failure,
}
