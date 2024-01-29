import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hue_dada/home/model/home.dart';
import 'package:hue_dada/home/repository/home_repository.dart';
import 'package:hue_dada/room/model/room.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(const HomeState());

  final HomeRepository _homeRepository;

  bool get canSwitchLightState =>
      state.home != null &&
      state.status != HomeStateStatus.homeLightStateUpdated &&
      state.rooms.any((room) => room.lights != null && room.lights!.isNotEmpty);

  Future<void> switchLightState(bool lightState) async {
    if (state.home == null || state.rooms.isEmpty) return;
    emit(state.copyWith(status: HomeStateStatus.updatingHomeLightState));
    await _homeRepository.switchLightState(lightState);
    emit(state.copyWith(
      home: state.home!.copyWith(isOn: lightState),
      status: HomeStateStatus.homeLightStateUpdated,
    ));
  }

  Future<void> listenHome() async {
    _homeRepository.getUserHome().snapshots().listen((home) {
      emit(state.copyWith(
        home: home.exists
            ? Home.fromFirebase(
                home.id,
                home.data() as Map<String, dynamic>,
              )
            : null,
        clearHome: !home.exists,
        status: HomeStateStatus.listenedHomeChanges,
      ));
    });
  }

  Future<void> listenRooms() async {
    _homeRepository.getUserRoomsCollection().snapshots().listen((rooms) {
      emit(state.copyWith(
        rooms: rooms.docs
            .map((room) => Room.fromFirebase(
                  room.id,
                  room.data() as Map<String, dynamic>,
                ))
            .toList(),
      ));
    });
  }
}
