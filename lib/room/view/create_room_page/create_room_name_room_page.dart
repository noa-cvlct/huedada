import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/room/bloc/create_room_cubit.dart';
import 'package:hue_dada/widgets/gradient_button.dart';
import 'package:hue_dada/widgets/input_field.dart';

@RoutePage()
class CreateRoomNameRoomPage extends StatelessWidget {
  const CreateRoomNameRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateRoomCubit>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
        ),
        child: Column(
          children: [
            const Text(
              'What type of room would you like to add?',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            InputField(
              label: 'Room name',
              onChanged: (value) => cubit.nameChanged(value),
            ),
            const SizedBox(height: 16),
            GradientButton(
                backgroundGradient: const LinearGradient(
                  colors: [
                    Color(0xFF00B0FF),
                    Color(0xFF3F51B5),
                  ],
                ),
                onPressed: cubit.checkName,
                child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
