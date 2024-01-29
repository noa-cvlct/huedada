import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/room/bloc/create_room_cubit.dart';
import 'package:hue_dada/room/view/widgets/room_icon.dart';

@RoutePage()
class CreateRoomSelectIconPage extends StatelessWidget {
  const CreateRoomSelectIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateRoomCubit>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What type of room would you like to add?',
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
                      label: 'Living room',
                      iconData: Icons.living,
                      onPressed: () => cubit.iconChanged(Icons.living),
                    ),
                    RoomIcon(
                      label: 'Kitchen',
                      iconData: Icons.kitchen,
                      onPressed: () => cubit.iconChanged(Icons.kitchen),
                    ),
                    RoomIcon(
                      label: 'Diner',
                      iconData: Icons.dining,
                      onPressed: () => cubit.iconChanged(Icons.dining),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoomIcon(
                      label: 'Bedroom',
                      iconData: Icons.bed,
                      onPressed: () => cubit.iconChanged(Icons.bed),
                    ),
                    RoomIcon(
                      label: "Children's bedroom",
                      iconData: Icons.bedroom_baby,
                      onPressed: () => cubit.iconChanged(Icons.bedroom_baby),
                    ),
                    RoomIcon(
                      label: 'Bathroom',
                      iconData: Icons.bathtub,
                      onPressed: () => cubit.iconChanged(Icons.bathtub),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoomIcon(
                      label: 'Living room',
                      iconData: Icons.living,
                      onPressed: () => cubit.iconChanged(Icons.living),
                    ),
                    RoomIcon(
                      label: 'Kitchen',
                      iconData: Icons.kitchen,
                      onPressed: () => cubit.iconChanged(Icons.kitchen),
                    ),
                    RoomIcon(
                      label: 'Diner',
                      iconData: Icons.dining,
                      onPressed: () => cubit.iconChanged(Icons.dining),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
