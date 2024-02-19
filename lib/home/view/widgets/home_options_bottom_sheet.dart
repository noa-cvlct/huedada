import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/auth/bloc/auth_cubit.dart';
import 'package:hue_dada/navigation/app_router.dart';

class HomeOptionsBottomSheet extends StatelessWidget {
  const HomeOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text('Add a new room', textAlign: TextAlign.center),
          onTap: () => router
            ..pop()
            ..push(
              const RoomRouterRoute(
                children: [
                  CreateRoomRouterRoute(),
                ],
              ),
            ),
        ),
        const Divider(),
        ListTile(
          title: const Text(
            'Sign out',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          onTap: () => context.read<AuthCubit>().logout(),
        ),
        const Divider(),
        ListTile(
          title: const Text(
            'Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onTap: router.pop,
        ),
      ],
    );
  }
}
