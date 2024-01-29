import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hue_dada/home/repository/home_repository.dart';

part 'create_home_state.dart';

class CreateHomeCubit extends Cubit<CreateHomeState> {
  CreateHomeCubit(
    this._homeRepository,
  ) : super(const CreateHomeState());

  final HomeRepository _homeRepository;

  void nameChanged(String name) => emit(state.copyWith(name: name));

  Future<void> createHome() async {
    if (state.name.isEmpty) return;
    emit(state.copyWith(status: CreateHomeStateStatus.loading));
    await _homeRepository.createUserDoc(state.name);
    emit(state.copyWith(status: CreateHomeStateStatus.success));
  }
}
