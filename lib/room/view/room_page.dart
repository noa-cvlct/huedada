import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/room/view/widgets/light_tile_widget.dart';
import 'package:hue_dada/room/view/widgets/room_options_bottom_sheet.dart';
import 'package:hue_dada/theme.dart';
import 'package:hue_dada/widgets/brightness_slider.dart';
import 'package:hue_dada/widgets/gradient_button.dart';
import 'package:hue_dada/widgets/input_switch.dart';

@RoutePage()
class RoomPage extends StatelessWidget {
  const RoomPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final cubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final room = state.home!.rooms.firstWhere((r) => r.id == roomId);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: darkGrey,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => AutoRouter.of(context).pop(),
            ),
            title: Text(room.name, style: const TextStyle(color: Colors.white)),
            actions: [
              InputSwitch(
                value: room.isOn,
                onChanged: cubit.canSwitchRoomLightState(room)
                    ? (value) => cubit.switchRoomLightState(room.id, value)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () => showModalBottomSheet(
                  showDragHandle: true,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => RoomOptionsBottomSheet(roomId: roomId),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: BrightnessSlider(
                  value: room.brightness,
                  onChanged: room.canChangeBrightness
                      ? (value) =>
                          cubit.changeRoomBrightness(room.id, value.toInt())
                      : null,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: room.lights.isEmpty
                      ? Column(
                          children: [
                            Text(
                              'Add lights',
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
                              'You have no light in ${room.name}. '
                              'First add a few rooms to control your home.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey.shade500),
                            ),
                            const SizedBox(height: 16),
                            GradientButton(
                              backgroundGradient: const LinearGradient(
                                colors: [
                                  Colors.purple,
                                  Colors.deepPurple,
                                ],
                              ),
                              onPressed: () => router
                                  .push(CreateLightRouterRoute(roomId: roomId)),
                              child: const Text(
                                'Add light',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'LIGHTS',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.85,
                                ),
                                itemCount: room.lights.length,
                                itemBuilder: (context, index) =>
                                    LightTileWidget(
                                  roomId: roomId,
                                  lightId: room.lights[index].id,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
