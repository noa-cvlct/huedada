import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/create_home_cubit.dart';
import 'package:hue_dada/home/repository/home_repository.dart';
import 'package:hue_dada/widgets/input_field.dart';
import 'package:hue_dada/widgets/loading_dialog.dart';

@RoutePage()
class CreateHomePage extends StatelessWidget {
  const CreateHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateHomeCubit(
        RepositoryProvider.of<HomeRepository>(context),
      ),
      child: BlocBuilder<CreateHomeCubit, CreateHomeState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<CreateHomeCubit>(context);

          return Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 56,
                    horizontal: 48,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'This device needs a Home. What will you call yours?',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        label: 'Home name',
                        onChanged: cubit.nameChanged,
                        onEditingComplete: cubit.createHome,
                      ),
                    ],
                  ),
                ),
                if (state.status == CreateHomeStateStatus.loading)
                  const LoadingDialog(),
              ],
            ),
          );
        },
      ),
    );
  }
}
