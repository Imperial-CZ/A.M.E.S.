import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextButton(
            onPressed: () {
              //TorchLightManager().enableTorch();
            },
            child: Text("Activer")),
        TextButton(
            onPressed: () {
              //TorchLightManager().disableTorch();
            },
            child: Text("Desactiver"))
      ],
    );
  }
}
