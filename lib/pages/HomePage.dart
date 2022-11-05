import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => HomePage(),
  );
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool _isReady = false;
  @override
  void initState() {
    super.initState();
    _setupCameras();
  }
  Future<void> _setupCameras() async {
    try {
      // initialize cameras.
      cameras = await availableCameras();
      final firstCamera = cameras!.first;
      // initialize camera controllers.
      controller = new CameraController(cameras![0], ResolutionPreset.medium);
      await controller!.initialize();
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (!_isReady) return new Container();
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a Picture"),
      ),
      body: Center(
        child: CameraPreview(controller!),
      ),
      floatingActionButton: ElevatedButton(
        child: Text("Add your picture to our gallery"),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await controller!.takePicture();
            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: '',
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.imagePath: image?.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }


}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Picture Added')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
          children:[Image(image: FileImage(File(imagePath))),Text("Your picture has been added to the gallery")]
      ),
    );
  }
}