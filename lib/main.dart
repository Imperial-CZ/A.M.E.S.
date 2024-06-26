import 'package:ames/ui/camera/camera_screen.dart';
import 'package:ames/ui/game/game_screen.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ames",
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
