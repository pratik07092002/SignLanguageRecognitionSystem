import 'package:app/screens/CameraDisplay.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({Key? key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    videoCamera();
  }

  void videoCamera() async {
    try {
      List<CameraDescription> cameras = await availableCameras();
      
      // Find the front camera or use the first camera if not found
      CameraDescription frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {
              if (cameraController.value.isInitialized) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraOpen(cam: cameraController),
                  ),
                );
              } else {
                Fluttertoast.showToast(msg: "Unable to Start Camera");
              }
            },
            child: Material(
              elevation: 4,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyan.shade100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.power_settings_new,
                        size: 40, color: Colors.blueGrey.shade500),
                    const SizedBox(height: 4),
                    Text(
                      "Start",
                      style:
                          TextStyle(color: Colors.blueGrey.shade500, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
