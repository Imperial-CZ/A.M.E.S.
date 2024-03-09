import 'package:ames/ui/game/cubit/game_state.dart';
import 'package:ames/core/json_parser/json_parser.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  Future<void> initialize() async {
    JsonParser jsonParser = JsonParser();
    await jsonParser.parse('assets/script.json');

    emit(GameLoaded(jsonParser: jsonParser));
  }
}
