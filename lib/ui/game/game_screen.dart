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
          return const CircularProgressIndicator();
        } else if (state is GameLoaded) {
          return Scaffold(
            body: GameWidget(
              game: GameManager(
                jsonParser: state.jsonParser,
              ),
              backgroundBuilder: (BuildContext context) {
                if(true) {
                  return Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: CameraPreview(
                      state.controller,
                    ),
                  );
                } else {
                  return Container(
                  color: Colors.black,
                );
                }

              },
            ),
          );
        } else {
          return Text("ERROR");
        }
      },
    );
  }
}
