import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app/app/inspection_onboarding/views/inspection_onboarding_view.dart';

import 'app/camera/take_picture_screen.dart';
import 'app/switch/my_app_color.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      themeMode: ThemeMode.system,


      home: InspectionOnboardingView(
        nextPage: TakePictureScreen(
          // Pass the appropriate camera to the TakePictureScreen widget.
          camera: firstCamera,
        ),
      ),
    ),
  );
}






