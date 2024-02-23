import 'package:ames/utils/jsonParser.dart';
import 'package:camera/camera.dart';

abstract class GameState {
  GameState();
}

class GameInitial extends GameState {
  GameInitial();
}

class GameLoaded extends GameState {
  JsonParser jsonParser;
  CameraController controller;
  bool isCamera = false;
  GameLoaded({required this.jsonParser,required this.controller});
}
