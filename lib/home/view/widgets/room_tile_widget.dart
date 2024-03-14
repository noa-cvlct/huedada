import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/home/bloc/home_cubit.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/room/view/widgets/room_options_bottom_sheet.dart';
import 'package:hue_dada/theme.dart';
import 'package:hue_dada/widgets/input_switch.dart';

class RoomTileWidget extends StatelessWidget {
  const RoomTileWidget({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final cubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final room = state.home!.rooms.firstWhere((r) => r.id == roomId);

        return Card(
          color: darkGrey,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => router.push(RoomRoute(roomId: room.id)),
            onLongPress: () => showModalBottomSheet(
              showDragHandle: true,
              useRootNavigator: true,
              isScrollControlled: true,
              context: context,
              builder: (context) => RoomOptionsBottomSheet(roomId: room.id),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(room.icon, color: Colors.white),
                  trailing: InputSwitch(
                    value: room.isOn,
                    onChanged: cubit.canSwitchRoomLightState(room)
                        ? (value) => cubit.switchRoomLightState(room.id, value)
                        : null,
                  ),
                  title: Text(room.name),
                  subtitle: Text(room.isOn ? 'Lights on' : 'Lights off'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
