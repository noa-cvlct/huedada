import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/theme.dart';
import 'package:hue_dada/widgets/input_switch.dart';

class LightTileWidget extends StatelessWidget {
  const LightTileWidget({
    super.key,
    required this.roomId,
    required this.lightId,
  });

  final String roomId;
  final String lightId;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final cubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final light = state.home!.rooms
            .firstWhere((r) => r.id == roomId)
            .lights
            .firstWhere((l) => l.id == lightId);

        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
                router.push(LightRoute(roomId: roomId, lightId: lightId)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Ink(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: light.isOn ? light.color : lightGrey,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Icon(
                            light.icon,
                            color: light.isOn ? lightGrey : Colors.white,
                          ),
                          Text(
                            light.name,
                            style: TextStyle(
                              color: light.isOn ? lightGrey : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Ink(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: darkGrey,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: InputSwitch(
                        value: light.isOn,
                        onChanged: cubit.canChangeLightState
                            ? (value) => cubit.switchLightState(light.id, value)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
