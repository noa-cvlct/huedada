import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hue_dada/navigation/app_router.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
          onPressed: () {
            router
              ..pop()
              ..push(
                const RoomRouterRoute(
                  children: [
                    CreateLightRoute(),
                  ],
                ),
              );
          },
          child: const Text('Add lights'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
          onPressed: () {
            router
              ..pop()
              ..push(
                const RoomRouterRoute(
                  children: [
                    CreateRoomRouterRoute(),
                  ],
                ),
              );
          },
          child: const Text('Add a new room'),
        ),
        const Divider(),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
          onPressed: router.pop,
          child: const Text('Cancel'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
