import 'package:ames/ui/game/cubit/game_cubit.dart';
import 'package:ames/ui/game/cubit/game_state.dart';
import 'package:ames/utils/game_manager.dart';
import 'package:ames/utils/jsonParser.dart';
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
          cubit.initialize();
          return CircularProgressIndicator();
        } else if (state is GameLoaded) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                GameWidget(
                  game: GameManager(
                    jsonParser: state.jsonParser,
                  ),
                ),
                CameraPreview(state.controller),
              ],
            ),
          );
        } else {
          return Text("ERROR");
        }
      },
    );
  }
}
