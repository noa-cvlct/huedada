import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/repository/home_repository.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/room/bloc/create_room_cubit.dart';

@RoutePage()
class CreateRoomRouterPage extends StatelessWidget {
  const CreateRoomRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) => CreateRoomCubit(
        RepositoryProvider.of<HomeRepository>(context),
      ),
      child: BlocListener<CreateRoomCubit, CreateRoomState>(
          listener: (context, state) {
            if (state.status == CreateRoomStateStatus.selectedIcon) {
              router.push(const CreateRoomNameRoomRoute());
            } else if (state.status == CreateRoomStateStatus.roomSaved) {
              router.navigate(const HomeRouterRoute());
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => router.back(),
              ),
            ),
            body: const AutoRouter(),
          )),
    );
  }
}
