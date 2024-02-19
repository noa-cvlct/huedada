import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/room/bloc/create_light_cubit.dart';
import 'package:hue_dada/widgets/gradient_button.dart';
import 'package:hue_dada/widgets/input_field.dart';

@RoutePage()
class CreateLightWriteNamePage extends StatelessWidget {
  const CreateLightWriteNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateLightCubit>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Give your light a name',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            InputField(
              label: 'Name',
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
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
