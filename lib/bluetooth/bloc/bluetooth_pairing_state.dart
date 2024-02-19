part of 'bluetooth_pairing_cubit.dart';

class BluetoothPairingState extends Equatable {
  const BluetoothPairingState({
    this.subscription,
    this.connectedDevice,
    this.availableDevices = const [],
    this.status = BluetoothPairingStateStatus.initial,
  });

  final StreamSubscription<List<ScanResult>>? subscription;

  final BluetoothDevice? connectedDevice;
  final List<BluetoothDevice> availableDevices;
  final BluetoothPairingStateStatus status;

  BluetoothPairingState copyWith({
    BluetoothDevice? connectedDevice,
    List<BluetoothDevice>? availableDevices,
    BluetoothPairingStateStatus? status,
  }) {
    return BluetoothPairingState(
      connectedDevice: connectedDevice ?? this.connectedDevice,
      availableDevices: availableDevices ?? this.availableDevices,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        connectedDevice,
        availableDevices,
        status,
      ];
}

enum BluetoothPairingStateStatus {
  initial,
  searchingDevices,
  pairingDevice,
  devicePaired,
}
