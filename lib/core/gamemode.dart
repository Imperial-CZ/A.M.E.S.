import 'package:flame/events.dart';

class GameMode {
  Function(TapDownInfo info)? currentGameMode;

  Function(TapDownInfo info) emptyGameMode = (TapDownInfo info) {};
}
