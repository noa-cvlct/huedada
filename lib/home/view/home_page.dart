import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/home/view/widgets/options_bottom_sheet.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/widgets/gradient_button.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              Switch(
                value: state.home?.isOn ?? false,
                onChanged:
                    cubit.canSwitchLightState ? cubit.switchLightState : null,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => showModalBottomSheet(
                  showDragHandle: true,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const OptionsBottomSheet(),
                ),
              ),
            ],
          ),
          body: state.home == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.home!.name,
                          style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 32),
                      state.rooms.isEmpty
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
                                      ?.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
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
                                )
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
                                ...state.rooms.map((room) => ListTile(
                                      title: Text(room.name),
                                      subtitle: Text(room.id),
                                    ))
                              ],
                            ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
