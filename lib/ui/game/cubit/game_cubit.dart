import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:ames/ui/game/cubit/game_state.dart';
import 'package:ames/core/json_parser/json_parser.dart';
import 'package:camera/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  late GameManager gameManager;
  late GameWidget gameWidget;

  Future<void> initialize(BuildContext context) async {
    JsonParser jsonParser = JsonParser();
    await jsonParser.parse('assets/script.json');

    gameManager = GameManager(jsonParser: jsonParser, context: context);
    gameWidget = GameWidget(game: gameManager);

    emit(GameLoaded(
      gameWidget: gameWidget,
      activateCamera: false,
    ));
  }

  Future<void> changeCameraState(bool activateCamera) async {
    if (activateCamera == true) {
      List<CameraDescription> _cameras = await availableCameras();
      CameraController controller =
          CameraController(_cameras[0], ResolutionPreset.max);
      await controller.initialize();

      emit(GameLoaded(
        gameWidget: gameWidget,
        cameraController: controller,
        activateCamera: true,
      ));
    } else {
      emit(GameLoaded(
        gameWidget: gameWidget,
        activateCamera: false,
      ));
    }
  }
}
