part of 'create_home_cubit.dart';

class CreateHomeState extends Equatable {
  const CreateHomeState({
    this.name = '',
    this.status = CreateHomeStateStatus.initial,
  });

  final String name;
  final CreateHomeStateStatus status;

  CreateHomeState copyWith({
    String? name,
    CreateHomeStateStatus? status,
  }) {
    return CreateHomeState(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        name,
        status,
      ];
}

enum CreateHomeStateStatus {
  initial,
  loading,
  success,
}
