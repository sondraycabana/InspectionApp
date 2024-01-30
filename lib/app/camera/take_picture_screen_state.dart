import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app/app/camera/take_picture_screen.dart';
import 'package:lottie/lottie.dart';

import 'display_picuture_screen.dart';

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