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
      child: BlocConsumer<CreateRoomCubit, CreateRoomState>(
        listener: (context, state) {
          if (state.status == CreateRoomStateStatus.selectedIcon) {
            router.push(const CreateRoomWriteNameRoute());
          } else if (state.status == CreateRoomStateStatus.selectedName) {
            context.read<CreateRoomCubit>().createRoom();
          } else if (state.status == CreateRoomStateStatus.roomSaved) {
            router.navigate(const HomeRouterRoute());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => router.back(),
              ),
            ),
            body: Stack(
              children: [
                const AutoRouter(),
                if (state.status == CreateRoomStateStatus.savingRoom)
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
