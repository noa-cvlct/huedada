import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/bluetooth/bloc/bluetooth_pairing_cubit.dart';
import 'package:hue_dada/bluetooth/repository/bluetooth_repository.dart';
import 'package:hue_dada/bluetooth/view/available_devices_widget.dart';
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
          create: (context) => HomeCubit(
            RepositoryProvider.of<HomeRepository>(context),
            RepositoryProvider.of<BluetoothRepository>(context),
          )
            ..listenHome()
            ..listenRooms(),
        ),
      ],
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStateStatus.listenHomeChanges) {
            if (state.home == null) {
              router.replace(const CreateHomeRoute());
            } else {
              router.replace(const HomeRoute());
            }
          }
        },
        child: BlocBuilder<BluetoothPairingCubit, BluetoothPairingState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  const AutoRouter(),
                  if (state.status ==
                          BluetoothPairingStateStatus.searchingDevices ||
                      state.status == BluetoothPairingStateStatus.pairingDevice)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.8),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: AvailableDevicesWidget(),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
