import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/home/view/widgets/options_bottom_sheet.dart';

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
                onChanged: cubit.switchLightState,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => showModalBottomSheet(
                    showDragHandle: true,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const OptionsBottomSheet()),
              )
            ],
          ),
          body: state.home == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Home', style: TextStyle(fontSize: 24)),
                      const SizedBox(height: 32),
                      const Text('ROOMS', style: TextStyle(fontSize: 12)),
                      state.rooms.isEmpty
                          ? const Text('Add a room or a light to get started')
                          : ListView(
                              shrinkWrap: true,
                              children: state.rooms
                                  .map((room) => ListTile(
                                        title: Text(room.name),
                                        subtitle: Text(room.id),
                                      ))
                                  .toList(),
                            ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
