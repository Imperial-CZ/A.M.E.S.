import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:ames/core/json_parser/json_parser.dart';
import 'package:camera/camera.dart';
import 'package:flame/game.dart';

abstract class GameState {
  GameState();
}

class GameInitial extends GameState {
  GameInitial();
}

class GameLoaded extends GameState {
  GameManager gameManager;
  CameraController cameraController;
  bool activateCamera;
  GameLoaded({
    required this.gameManager,
    required this.cameraController,
    required this.activateCamera,
  });
}
