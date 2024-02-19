import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hue_dada/bluetooth/repository/bluetooth_repository.dart';

part 'bluetooth_pairing_state.dart';

class BluetoothPairingCubit extends Cubit<BluetoothPairingState> {
  BluetoothPairingCubit(this._bluetoothRepository)
      : super(const BluetoothPairingState()) {
    final connectedDevices = FlutterBluePlus.connectedDevices;
    if (connectedDevices.isEmpty) {
      emit(
        state.copyWith(status: BluetoothPairingStateStatus.searchingDevices),
      );
    }
  }

  final BluetoothRepository _bluetoothRepository;

  Future<void> startPairing() async {
    await FlutterBluePlus.startScan();
    final subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        for (final scanResult in results) {
          addAvailableDevice(scanResult.device);
        }
      },
    );
    FlutterBluePlus.cancelWhenScanComplete(subscription);
  }

  void addAvailableDevice(BluetoothDevice device) {
    if (device.advName.isEmpty || state.availableDevices.contains(device)) {
      return;
    }

    final availableDevices = List<BluetoothDevice>.from(state.availableDevices);
    availableDevices.add(device);
    emit(state.copyWith(availableDevices: availableDevices));
  }

  Future<void> pairDevice(BluetoothDevice device) async {
    emit(state.copyWith(status: BluetoothPairingStateStatus.pairingDevice));
    FlutterBluePlus.stopScan();
    state.subscription?.cancel();
    await device.connect();
    await device.discoverServices();
    _bluetoothRepository.device = device;
    emit(state.copyWith(
      connectedDevice: device,
      status: BluetoothPairingStateStatus.devicePaired,
    ));
  }

  @override
  Future<void> close() {
    FlutterBluePlus.stopScan();
    state.subscription?.cancel();
    return super.close();
  }
}
