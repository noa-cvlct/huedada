import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hue_dada/light/model/light.dart';

class BluetoothRepository {
  static const String serviceUuid = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
  static const String characteristicUuid =
      'beb5483e-36e1-4688-b7f5-ea07361b26a8';

  BluetoothDevice? device;

  Future<void> sendDataToBluetoothDevice(
    Light light,
  ) async {
    if (device == null) return;
    try {
      final service =
          device!.servicesList.firstWhere((s) => s.uuid == Guid(serviceUuid));
      final characteristic = service.characteristics
          .firstWhere((c) => c.uuid == Guid(characteristicUuid));
      if (device!.isConnected == true) {
        String data = '${light.type.toFirebase()} '
            '${light.isOn} '
            '${light.syncWithSound} '
            '${light.brightness} '
            '${light.color.red} '
            '${light.color.green} '
            '${light.color.blue}';

        await characteristic.write(data.codeUnits);
      }
    } catch (e) {
      print('Erreur lors de l\'envoi des données : $e');
    }
  }
}
