import 'package:ames/ui/game/cubit/game_state.dart';
import 'package:ames/utils/jsonParser.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  late CameraController controller;

  Future<void> initialize() async {
    List<CameraDescription> _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max); // Caméra arrière
    await controller.initialize();

    JsonParser jsonParser = JsonParser();
    await jsonParser.parse('assets/script.json');

    emit(GameLoaded(jsonParser: jsonParser, controller: controller));
  }
}
