import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_cubit.dart';

class CameraScreen extends StatelessWidget{

  CameraCubit cubit = CameraCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is CameraInit) {
          cubit.initCamera();
          return CircularProgressIndicator();
        } else if (state is CameraLoaded) {
          return CameraPreview(state.controller);
        }
        return Text("ERROR");
      },
    );
  }

}