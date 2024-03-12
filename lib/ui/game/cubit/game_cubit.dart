import 'dart:io';
import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:ames/ui/game/cubit/game_state.dart';
import 'package:ames/core/json_parser/json_parser.dart';
import 'package:camera/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  late GameManager gameManager;
  late CameraController controller;

  Future<void> initialize(BuildContext context) async {
    JsonParser jsonParser = JsonParser();
    await jsonParser.parse('assets/script.json');

    List<CameraDescription> _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);

    var cameraStatus = Permission.camera;
    if (await cameraStatus.isDenied) {
      if ((await Permission.camera.request()).isGranted == false) {
        exit(0);
      }
    } else if (await cameraStatus.isGranted == false) {
      exit(0);
    }

    var microphoneStatus = Permission.microphone;
    if (await microphoneStatus.isDenied) {
      if ((await Permission.microphone.request()).isGranted == false) {
        exit(0);
      }
    } else if (await microphoneStatus.isGranted == false) {
      exit(0);
    }

    gameManager = GameManager(jsonParser: jsonParser, context: context);

    emit(GameLoaded(
      gameManager: gameManager,
      cameraController: controller,
      activateCamera: false,
    ));
  }

  Future<void> changeCameraState(bool activateCamera) async {
    if (activateCamera == true) {
      await controller.initialize();

      emit(GameLoaded(
        gameManager: gameManager,
        cameraController: controller,
        activateCamera: true,
      ));
    } else {
      emit(GameLoaded(
        gameManager: gameManager,
        cameraController: controller,
        activateCamera: false,
      ));
    }
  }
}
