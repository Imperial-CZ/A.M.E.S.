part of 'camera_cubit.dart';

@immutable
abstract class CameraState {}

class CameraInit extends CameraState {
}
class CameraLoaded extends CameraState {
  CameraController controller;
  CameraLoaded({required this.controller});
}
class CameraError extends CameraState {
  String error;
  CameraError({required this.error});
}
