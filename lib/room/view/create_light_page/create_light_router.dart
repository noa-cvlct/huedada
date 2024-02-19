import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/repository/home_repository.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/room/bloc/create_light_cubit.dart';

@RoutePage()
class CreateLightRouterPage extends StatelessWidget {
  const CreateLightRouterPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) => CreateLightCubit(
        RepositoryProvider.of<HomeRepository>(context),
        roomId: roomId,
      ),
      child: BlocConsumer<CreateLightCubit, CreateLightState>(
        listener: (context, state) {
          if (state.status == CreateLightStateStatus.selectedIcon) {
            router.push(const CreateLightWriteNameRoute());
          } else if (state.status == CreateLightStateStatus.selectedName) {
            context.read<CreateLightCubit>().createLight();
          } else if (state.status == CreateLightStateStatus.lightSaved) {
            router.navigate(RoomRoute(roomId: roomId));
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
                if (state.status == CreateLightStateStatus.savingLight)
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
