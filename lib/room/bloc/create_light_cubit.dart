import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hue_dada/home/repository/home_repository.dart';
import 'package:hue_dada/light/model/light.dart';

part 'create_light_state.dart';

class CreateLightCubit extends Cubit<CreateLightState> {
  CreateLightCubit(this._homeRepository, {required String roomId})
      : super(CreateLightState(roomId: roomId));

  final HomeRepository _homeRepository;

  void typeChanged(IconData value, LightType type) {
    emit(state.copyWith(
      icon: value,
      type: type,
      status: CreateLightStateStatus.selectedIcon,
    ));
  }

  void nameChanged(String value) {
    emit(state.copyWith(
        name: value, status: CreateLightStateStatus.enteringName));
  }

  void checkName() {
    if (state.name.isNotEmpty) {
      emit(state.copyWith(status: CreateLightStateStatus.selectedName));
    }
  }

  Future<void> createLight() async {
    emit(state.copyWith(status: CreateLightStateStatus.savingLight));
    await _homeRepository.createLight(
      state.roomId,
      state.name,
      state.icon!,
      state.type!,
    );
    emit(state.copyWith(status: CreateLightStateStatus.lightSaved));
  }
}
