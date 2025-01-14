import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
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
        ListTile(
          title: const Text(
            'Delete room',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete room'),
                content:
                    const Text('Are you sure you want to delete this room?'),
                actions: [
                  TextButton(
                    onPressed: router.pop,
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                      BlocProvider.of<HomeCubit>(context).deleteRoom(roomId);
                      router.navigate(const HomeRoute());
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(),
        ListTile(
          title: const Text(
            'Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          onTap: router.pop,
        ),
      ],
    );
  }
}
