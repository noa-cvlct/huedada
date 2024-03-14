import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/theme.dart';
import 'package:hue_dada/widgets/brightness_slider.dart';
import 'package:hue_dada/widgets/input_switch.dart';

@RoutePage()
class LightPage extends StatelessWidget {
  const LightPage({
    super.key,
    required this.roomId,
    required this.lightId,
  });

  final String roomId;
  final String lightId;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final room = state.home!.rooms.firstWhere((r) => r.id == roomId);
        final light = room.lights.firstWhere((l) => l.id == lightId);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: darkGrey,
            leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              light.name,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                splashColor:
                    cubit.canChangeLightState ? Colors.white : darkGrey,
                onPressed: cubit.canChangeSyncWithSound
                    ? () => cubit.switchLightSyncWithSound(
                          lightId,
                          !light.syncWithSound,
                        )
                    : null,
                icon: Icon(
                  Icons.music_note,
                  color: cubit.canChangeSyncWithSound
                      ? light.syncWithSound
                          ? Colors.white
                          : lightGrey
                      : darkGrey,
                ),
              ),
              InputSwitch(
                value: light.isOn,
                onChanged: cubit.canChangeLightState
                    ? (value) => cubit.switchLightState(lightId, value)
                    : null,
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: light.color,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: BrightnessSlider(
                  value: light.brightness,
                  onChanged: light.isOn
                      ? (value) =>
                          cubit.changeLightBrightness(light.id, value.toInt())
                      : null,
                ),
              ),
              ColorPicker(
                pickerColor: light.color,
                paletteType: PaletteType.hueWheel,
                enableAlpha: false,
                labelTypes: const [],
                portraitOnly: true,
                colorPickerWidth: 300,
                onColorChanged: (Color color) =>
                    cubit.switchLightColor(lightId, color),
              ),
              const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
