import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class Sound {
  static AudioPlayer player = AudioPlayer();
  String filename;
  int duration;
  bool loop;
  int volume;
  String? filePath;

  Sound({
    required this.filename,
    required this.duration,
    required this.loop,
    required this.volume,
  }) {
    filePath = "$filename.mp3";
  }

  Future play() async {
    if (filePath != null) {
      final result = await player.play(filePath as Source);
    }
  }

  Future pause() async {
    if (filePath != null) {
      final result = await player.pause();
    }
  }

  Future stop() async {
    if (filePath != null) {
      final result = await player.stop();
    }
  }
}
