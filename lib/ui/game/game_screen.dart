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

  // final cubit = GameCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state is GameInitial) {
            BlocProvider.of<GameCubit>(context).initialize(context);
            return CircularProgressIndicator();
          } else if (state is GameLoaded) {
            return GameWidget(
              game: state.gameManager,
              backgroundBuilder: state.activateCamera == true
                  ? (context) {
                      return Scaffold(
                        body: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CameraPreview(
                            state.cameraController,
                          ),
                        ),
                      );
                    }
                  : null,
            );
          } else {
            return Text("ERROR");
          }
        },
      ),
    );
  }
}
