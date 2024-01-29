import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hue_dada/home/repository/home_repository.dart';

part 'create_room_state.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  CreateRoomCubit(this._homeRepository) : super(const CreateRoomState());

  final HomeRepository _homeRepository;

  void iconChanged(IconData value) {
    emit(state.copyWith(
      icon: value,
      status: CreateRoomStateStatus.selectedIcon,
    ));
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void checkName() {
    if (state.name.isNotEmpty) {
      emit(state.copyWith(status: CreateRoomStateStatus.selectedName));
    }
  }

  Future<void> createRoom() async {
    emit(state.copyWith(status: CreateRoomStateStatus.savingRoom));
    await _homeRepository.createRoom(state.name, state.icon!);
    emit(state.copyWith(status: CreateRoomStateStatus.roomSaved));
  }
}
