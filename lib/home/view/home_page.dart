import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/home/view/widgets/home_options_bottom_sheet.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/widgets/gradient_button.dart';
import 'package:hue_dada/widgets/input_switch.dart';

import 'widgets/room_tile_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final cubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.home?.name ?? "",
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              InputSwitch(
                value: state.home?.isOn ?? false,
                onChanged: cubit.canChangeHomeLightState
                    ? cubit.switchHomeLightState
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () => showModalBottomSheet(
                  showDragHandle: true,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const HomeOptionsBottomSheet(),
                ),
              ),
            ],
          ),
          body: state.home == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: state.home!.rooms.isEmpty
                      ? Column(
                          children: [
                            Text(
                              'Add rooms',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'You have no room in ${state.home!.name}. '
                              'First add a few rooms to control your home.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey.shade500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            GradientButton(
                              backgroundGradient: const LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.deepOrange,
                                ],
                              ),
                              onPressed: () => router.push(
                                const RoomRouterRoute(
                                  children: [
                                    CreateRoomRouterRoute(),
                                  ],
                                ),
                              ),
                              child: const Text(
                                'Add room',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            const Text(
                              'ROOMS',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            ...state.home!.rooms.map(
                              (room) => RoomTileWidget(roomId: room.id),
                            ),
                          ],
                        ),
                ),
        );
      },
    );
  }
}
