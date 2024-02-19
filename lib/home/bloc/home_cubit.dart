import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:equatable/equatable.dart';
import 'package:hue_dada/bluetooth/repository/bluetooth_repository.dart';
import 'package:hue_dada/home/model/home.dart';
import 'package:hue_dada/home/repository/home_repository.dart';
import 'package:hue_dada/light/model/light.dart';
import 'package:hue_dada/room/model/room.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository, this._bluetoothRepository)
      : super(const HomeState());

  final HomeRepository _homeRepository;
  final BluetoothRepository _bluetoothRepository;

  StreamSubscription<Home?>? _homeListener;
  StreamSubscription<List<Room>>? _roomsListener;
  final List<StreamSubscription<List<Light>>> _roomLightsListeners = [];

  bool get canChangeHomeLightState =>
      state.status != HomeStateStatus.updatingHomeLightState &&
      state.home != null &&
      state.home!.rooms.any((r) => r.lights.isNotEmpty);

  bool canSwitchRoomLightState(Room room) =>
      state.status != HomeStateStatus.updatingHomeLightState &&
      state.status != HomeStateStatus.updatingRoomLightState &&
      room.canSwitchLightState;

  bool canChangeRoomBrightness(Room room) =>
      state.status != HomeStateStatus.updatingRoomBrightness &&
      room.canChangeBrightness;

  bool get canChangeLightState =>
      state.status != HomeStateStatus.updatingRoomLightState &&
      state.status != HomeStateStatus.updatingLightState;

  bool get canChangeSyncWithSound =>
      state.status != HomeStateStatus.updatingLightSyncWithSound;

  Future<void> switchHomeLightState(bool lightState) async {
    if (state.home == null || state.home!.rooms.isEmpty) return;
    emit(state.copyWith(status: HomeStateStatus.updatingHomeLightState));

    await _homeRepository.switchHomeLightState(lightState);
    for (final room in state.home!.rooms) {
      if (room.canSwitchLightState) {
        await _homeRepository.switchRoomLightState(room.id, lightState);
        for (final light in room.lights) {
          await _homeRepository.switchLightState(room.id, light.id, lightState);
          await _bluetoothRepository.sendDataToBluetoothDevice(
            room.lights.firstWhere((l) => l.id == light.id).copyWith(
                  isOn: lightState,
                ),
          );
        }
      }
    }

    emit(state.copyWith(
      home: state.home!.copyWith(
        isOn: lightState,
        rooms: state.home!.rooms
            .map(
              (r) => r.copyWith(
                isOn: r.canSwitchLightState ? lightState : r.isOn,
                lights:
                    r.lights.map((l) => l.copyWith(isOn: lightState)).toList(),
              ),
            )
            .toList(),
      ),
      status: HomeStateStatus.homeLightStateUpdated,
    ));
  }

  Future<void> switchRoomLightState(String roomId, bool roomState) async {
    emit(state.copyWith(status: HomeStateStatus.updatingRoomLightState));

    await _homeRepository.switchRoomLightState(roomId, roomState);
    final room = state.home!.rooms.firstWhere((r) => r.id == roomId);
    for (final light in room.lights) {
      await _homeRepository.switchLightState(roomId, light.id, roomState);
      await _bluetoothRepository.sendDataToBluetoothDevice(
        room.lights.firstWhere((l) => l.id == light.id).copyWith(
              isOn: roomState,
            ),
      );
    }

    emit(state.copyWith(
      home: state.home!.copyWith(
        isOn: state.home!.hasRoomsOnAfterChange(room, roomState),
        rooms: state.home!.rooms
            .map(
              (r) => r.id == roomId
                  ? r.copyWith(
                      isOn: roomState,
                      lights: r.lights
                          .map((l) => l.copyWith(isOn: roomState))
                          .toList(),
                    )
                  : r,
            )
            .toList(),
      ),
      status: HomeStateStatus.roomLightStateUpdated,
    ));
  }

  Future<void> switchLightState(String lightId, bool lightState) async {
    emit(state.copyWith(status: HomeStateStatus.updatingLightState));
    final room = state.home!.rooms
        .firstWhere((r) => r.lights.any((l) => l.id == lightId));

    final isRoomOn = room.hasLightsOnAfterChange(lightId, lightState);
    if (isRoomOn) {
      await _homeRepository.switchRoomLightState(room.id, lightState);
    }
    await _homeRepository.switchLightState(room.id, lightId, lightState);
    await _bluetoothRepository.sendDataToBluetoothDevice(
      room.lights.firstWhere((l) => l.id == lightId).copyWith(
            isOn: lightState,
          ),
    );

    emit(state.copyWith(
      home: state.home!.copyWith(
        isOn: state.home!.hasRoomsOnAfterChange(room, isRoomOn),
        rooms: state.home!.rooms
            .map(
              (r) => r.copyWith(
                isOn: r.canSwitchLightState ? isRoomOn : r.isOn,
                lights: r.lights
                    .map((l) =>
                        l.id == lightId ? l.copyWith(isOn: lightState) : l)
                    .toList(),
              ),
            )
            .toList(),
      ),
      status: HomeStateStatus.lightStateUpdated,
    ));
  }

  Future<void> switchLightColor(String lightId, Color color) async {
    emit(state.copyWith(status: HomeStateStatus.updatingLightColor));
    final room = state.home!.rooms
        .firstWhere((r) => r.lights.any((l) => l.id == lightId));
    EasyDebounce.debounce(lightId, const Duration(seconds: 1), () async {
      await _homeRepository.switchLightColor(room.id, lightId, color);
      await _bluetoothRepository.sendDataToBluetoothDevice(
        room.lights.firstWhere((l) => l.id == lightId).copyWith(
              color: color,
            ),
      );
    });
    emit(state.copyWith(
      home: state.home!.copyWith(
        rooms: state.home!.rooms
            .map(
              (r) => r.copyWith(
                lights: r.lights
                    .map((l) => l.id == lightId ? l.copyWith(color: color) : l)
                    .toList(),
              ),
            )
            .toList(),
      ),
      status: HomeStateStatus.lightColorUpdated,
    ));
  }

  Future<void> changeRoomBrightness(String roomId, int brightness) async {
    emit(state.copyWith(status: HomeStateStatus.updatingRoomBrightness));

    EasyDebounce.debounce(roomId, const Duration(seconds: 1), () async {
      await _homeRepository.changeRoomBrightness(roomId, brightness);
      final room = state.home!.rooms.firstWhere((r) => r.id == roomId);
      for (final light in room.lights) {
        await _homeRepository.changeLightBrightness(
          roomId,
          light.id,
          brightness,
        );
        await _bluetoothRepository.sendDataToBluetoothDevice(
          room.lights.firstWhere((l) => l.id == light.id).copyWith(
                brightness: brightness,
              ),
        );
      }
    });

    emit(state.copyWith(
      home: state.home!.copyWith(
        rooms: state.home!.rooms
            .map(
              (r) => r.id == roomId
                  ? r.copyWith(
                      brightness: brightness,
                      lights: r.lights
                          .map((l) => l.copyWith(brightness: brightness))
                          .toList(),
                    )
                  : r,
            )
            .toList(),
      ),
      status: HomeStateStatus.roomBrightnessUpdated,
    ));
  }

  Future<void> changeLightBrightness(String lightId, int brightness) async {
    emit(state.copyWith(status: HomeStateStatus.updatingLightBrightness));

    final room = state.home!.rooms
        .firstWhere((r) => r.lights.any((l) => l.id == lightId));
    EasyDebounce.debounce(lightId, const Duration(seconds: 1), () async {
      await _homeRepository.changeLightBrightness(room.id, lightId, brightness);
      await _bluetoothRepository.sendDataToBluetoothDevice(
        room.lights.firstWhere((l) => l.id == lightId).copyWith(
              brightness: brightness,
            ),
      );
    });

    emit(state.copyWith(
      home: state.home!.copyWith(
        rooms: state.home!.rooms
            .map((r) => r.copyWith(
                  lights: r.lights
                      .map((l) => l.id == lightId
                          ? l.copyWith(brightness: brightness)
                          : l)
                      .toList(),
                ))
            .toList(),
      ),
      status: HomeStateStatus.lightBrightnessUpdated,
    ));
  }

  Future<void> switchLightSyncWithSound(
      String lightId, bool syncWithSound) async {
    emit(state.copyWith(status: HomeStateStatus.updatingLightSyncWithSound));

    final room = state.home!.rooms
        .firstWhere((r) => r.lights.any((l) => l.id == lightId));
    await _homeRepository.changeLightSyncWithSound(
        room.id, lightId, syncWithSound);
    await _bluetoothRepository.sendDataToBluetoothDevice(
      room.lights.firstWhere((l) => l.id == lightId).copyWith(
            syncWithSound: syncWithSound,
          ),
    );

    emit(state.copyWith(
      home: state.home!.copyWith(
        rooms: state.home!.rooms
            .map((r) => r.copyWith(
                  lights: r.lights
                      .map((l) => l.id == lightId
                          ? l.copyWith(syncWithSound: syncWithSound)
                          : l)
                      .toList(),
                ))
            .toList(),
      ),
      status: HomeStateStatus.lightSyncWithSoundUpdated,
    ));
  }

  Future<void> listenHome() async {
    _homeListener?.cancel();
    _homeListener = _homeRepository.getUserHome().listen((home) {
      emit(state.copyWith(
        home: home?.copyWith(
          rooms: state.home?.rooms ?? [],
        ),
        nullableHome: true,
        status: (home == null && state.home == null) ||
                (home != null && state.home == null) ||
                (home == null && state.home != null)
            ? HomeStateStatus.listenHomeChanges
            : state.status,
      ));
    });
  }

  Future<void> listenRooms() async {
    _roomsListener?.cancel();
    _roomsListener = _homeRepository.getUserRooms().listen((rooms) {
      for (final listener in _roomLightsListeners) {
        listener.cancel();
      }
      _roomLightsListeners.clear();
      for (final room in rooms) {
        listenRoomLights(room.id);
      }
      if (state.home?.rooms.length != rooms.length) {
        emit(state.copyWith(
          home: state.home?.copyWith(
            rooms: rooms,
          ),
        ));
      }
    });
  }

  Future<void> listenRoomLights(String roomId) async {
    _roomLightsListeners.add(
      _homeRepository.getUserRoomLights(roomId).listen((lights) {
        final room = state.home?.rooms.firstWhere((r) => r.id == roomId);

        if (room?.lights.length != lights.length) {
          emit(state.copyWith(
            home: state.home?.copyWith(
              rooms: state.home!.rooms
                  .map((r) => r.id == roomId ? r.copyWith(lights: lights) : r)
                  .toList(),
            ),
          ));
        }
      }),
    );
  }

  @override
  Future<void> close() {
    _homeListener?.cancel();
    _roomsListener?.cancel();
    for (final listener in _roomLightsListeners) {
      listener.cancel();
    }
    return super.close();
  }
}
