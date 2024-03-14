import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';

class LightOptionsBottomSheet extends StatelessWidget {
  const LightOptionsBottomSheet({
    super.key,
    required this.roomId,
    required this.lightId,
  });

  final String roomId;
  final String lightId;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text(
            'Delete light',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete light'),
                content:
                    const Text('Are you sure you want to delete this light?'),
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
                      BlocProvider.of<HomeCubit>(context)
                          .deleteLight(roomId, lightId);
                      router.back();
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
