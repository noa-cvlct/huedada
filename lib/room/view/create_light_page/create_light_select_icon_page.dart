import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/light/model/light.dart';
import 'package:hue_dada/room/bloc/create_light_cubit.dart';
import 'package:hue_dada/room/view/widgets/room_icon.dart';

@RoutePage()
class CreateLightSelectIconPage extends StatelessWidget {
  const CreateLightSelectIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateLightCubit>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What type of light would you like to add?',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text('TRADITIONAL', style: TextStyle(fontSize: 12)),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoomIcon(
                      label: 'Light',
                      iconData: Icons.lightbulb,
                      onPressed: () => cubit.typeChanged(
                        Icons.lightbulb,
                        LightType.light,
                      ),
                    ),
                    RoomIcon(
                      label: 'Led bar',
                      iconData: Icons.wb_iridescent_outlined,
                      onPressed: () => cubit.typeChanged(
                        Icons.wb_iridescent_outlined,
                        LightType.ledBar,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
