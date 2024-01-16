import 'package:ames/utils/jsonParser.dart';

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
