import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app/app/camera/take_picture_screen_state.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}