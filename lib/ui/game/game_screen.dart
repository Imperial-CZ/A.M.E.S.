import 'package:ames/ui/game/cubit/game_cubit.dart';
import 'package:ames/ui/game/cubit/game_state.dart';
import 'package:ames/utils/game_manager.dart';
import 'package:ames/utils/jsonParser.dart';
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
            backgroundColor: Color(0xffece1cd),
            body: GameWidget(
              game: GameManager(
                jsonParser: state.jsonParser,
              ),
            ),
          );
        } else {
          return Text("ERROR");
        }
      },
    );
  }
}
