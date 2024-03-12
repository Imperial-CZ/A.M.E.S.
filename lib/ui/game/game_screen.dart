import 'package:ames/ui/game/cubit/game_cubit.dart';
import 'package:ames/ui/game/cubit/game_state.dart';
import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:ames/core/json_parser/json_parser.dart';
import 'package:camera/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  final cubit = GameCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GameInitial) {
          cubit.initialize(context);
          return CircularProgressIndicator();
        } else if (state is GameLoaded) {
          if (state.activateCamera == false) {
            return Scaffold(
              backgroundColor: Color(0xffece1cd),
              body: state.gameWidget,
            );
          } else if (state.cameraController != null) {
            return Scaffold(
              backgroundColor: Color(0xffece1cd),
              body: CameraPreview(
                state.cameraController!,
                child: state.gameWidget,
              ),
            );
          } else {
            return Text("ERROR");
          }
        } else {
          return Text("ERROR");
        }
      },
    );
  }
}
