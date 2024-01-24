import 'package:torch_light/torch_light.dart';

class TorchLightManager {
  final bool isTorchAvailable = false;

  Future<void> enableTorch() async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      print('Could not enable Flashlight');
    }
  }

  Future<void> disableTorch() async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      print('Could not enable Flashlight');
    }
  }
}
