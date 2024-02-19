import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hue_dada/navigation/app_router.dart';

class RoomOptionsBottomSheet extends StatelessWidget {
  const RoomOptionsBottomSheet({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text(
            'Add light',
            textAlign: TextAlign.center,
          ),
          onTap: () {
            router.pop();
            router.push(CreateLightRouterRoute(roomId: roomId));
          },
        ),
        const Divider(),
        ListTile(
          title: const Text(
            'Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
          onTap: router.pop,
        ),
      ],
    );
  }
}
