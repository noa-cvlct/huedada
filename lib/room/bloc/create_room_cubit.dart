import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_room_state.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  CreateRoomCubit() : super(const CreateRoomState());
}
