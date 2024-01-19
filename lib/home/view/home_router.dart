import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/home/repository/home_repository.dart';
import 'package:hue_dada/navigation/app_router.dart';

@RoutePage()
class HomeRouterPage extends StatelessWidget {
  const HomeRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                HomeCubit(RepositoryProvider.of<HomeRepository>(context))
                  ..listenHome()
                  ..listenRooms(),
          ),
        ],
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.status == HomeStateStatus.listenedHomeChanges) {
              if (state.home == null) {
                router.replace(const CreateHomeRoute());
              } else {
                router.replace(const HomeRoute());
              }
            }
          },
          child: const AutoRouter(),
        ));
  }
}
