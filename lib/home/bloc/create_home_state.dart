part of 'create_home_cubit.dart';

class CreateHomeState extends Equatable {
  const CreateHomeState({
    this.name = '',
    this.status = CreateHomeStatus.initial,
  });

  final String name;
  final CreateHomeStatus status;

  CreateHomeState copyWith({
    String? name,
    CreateHomeStatus? status,
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

enum CreateHomeStatus {
  initial,
  loading,
  success,
}
