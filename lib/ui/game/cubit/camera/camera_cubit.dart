import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInit());

  late CameraController controller;

  Future<void> initCamera() async {
    List<CameraDescription> _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    await controller.initialize();

    emit(CameraLoaded(controller: controller));
  }
}
