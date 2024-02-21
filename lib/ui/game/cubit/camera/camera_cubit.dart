import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInit());

  late CameraController controller;

  Future<void> initCamera() async {


    emit(CameraLoaded(controller: controller));
  }
}
