part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.home,
    this.status = HomeStateStatus.initial,
  });

  final Home? home;
  final HomeStateStatus status;

  HomeState copyWith({
    Home? home,
    HomeStateStatus? status,
    bool nullableHome = false,
  }) {
    return HomeState(
      home: nullableHome ? home : home ?? this.home,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        home,
        status,
      ];
}

enum HomeStateStatus {
  initial,
  listenHomeChanges,

  updatingHomeLightState,
  homeLightStateUpdated,

  updatingRoomLightState,
  roomLightStateUpdated,
  updatingRoomBrightness,
  roomBrightnessUpdated,

  updatingLightState,
  lightStateUpdated,
  updatingLightColor,
  lightColorUpdated,
  updatingLightBrightness,
  lightBrightnessUpdated,
  updatingLightSyncWithSound,
  lightSyncWithSoundUpdated,
}
