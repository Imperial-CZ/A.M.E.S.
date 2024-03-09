import 'package:ames/core/json_parser/json_parser.dart';

abstract class GameState {
  GameState();
}

class GameInitial extends GameState {
  GameInitial();
}

class GameLoaded extends GameState {
  JsonParser jsonParser;
  GameLoaded({required this.jsonParser});
}
