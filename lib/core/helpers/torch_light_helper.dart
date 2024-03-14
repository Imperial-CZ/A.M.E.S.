import 'package:torch_light/torch_light.dart';

class TorchLightHelper {
  final bool isTorchAvailable = false;

  Future<void> enableTorch() async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (error) {
      print('Could not enable Flashlight ERROR : ' + error.toString());
    }
  }

  Future<void> disableTorch() async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      print('Could not enable Flashlight');
    }
  }
}
