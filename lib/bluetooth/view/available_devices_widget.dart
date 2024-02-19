import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/bluetooth/bloc/bluetooth_pairing_cubit.dart';

class AvailableDevicesWidget extends StatelessWidget {
  const AvailableDevicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothPairingCubit, BluetoothPairingState>(
      builder: (context, state) {
        if (state.status == BluetoothPairingStateStatus.pairingDevice) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Pairing device...',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: AppBar().preferredSize.height),
            const Text(
              'Available devices',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: ListView(
                children: state.availableDevices
                    .map(
                      (device) => ListTile(
                        title: Text(
                          device.advName.isEmpty
                              ? "Unavailable name"
                              : device.advName,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          device.remoteId.str,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          context
                              .read<BluetoothPairingCubit>()
                              .pairDevice(device);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
