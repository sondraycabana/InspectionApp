import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app/app/inspection_onboarding/views/inspection_onboarding_view.dart';
import 'package:lottie/lottie.dart';

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
      theme: ThemeData.dark(),
      home: InspectionOnboardingView(
        nextPage: TakePictureScreen(
          // Pass the appropriate camera to the TakePictureScreen widget.
          camera: firstCamera,
        ),
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  bool orientateToLandscapeLeft = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      // Set landscape orientation
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);

      setState(() {
        orientateToLandscapeLeft = true;
      });
    });

    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.max,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onPressedCapture() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await _controller.takePicture();

      if (!mounted) return;

      // If the picture was taken, display it on a new screen.
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return SizedBox(
                  height: size.height,
                  width: size.width,
                  child: CameraPreview(
                    _controller,
                    child: orientateToLandscapeLeft
                        ? const SizedBox()
                        : Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Lottie.asset(
                          "assets/json/1706363241942.json",
                          height: size.width * .65,
                          width: size.width * .65,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * .3),
                          child: const Text("Rotate Device"),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          orientateToLandscapeLeft
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height,
                    width: size.width * .09,
                    color: Colors.black38,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 5,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: size.height,
                width: size.width * .13,
                color: Colors.black38,
                child: Center(
                  child: GestureDetector(
                    onTap: _onPressedCapture,
                    child: const CircleAvatar(
                      radius: 34,
                      backgroundColor: Color(0xffDCDCDC),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black54,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}