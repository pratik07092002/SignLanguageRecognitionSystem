import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({Key? key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  late List<CameraDescription> Cameras;
  late CameraController cameraController;
  @override
  void initState() {
    videoCamera();
    // TODO: implement initState
    super.initState();
  }
  void videoCamera() async{
    Cameras = await availableCameras();
cameraController = CameraController(Cameras[0], ResolutionPreset.high , enableAudio: false);
await cameraController.initialize().then((value) {
if(!mounted){
  return;
}
else{
  setState(() {
    
  });
}
}).catchError((e){
Fluttertoast.showToast(msg: e.toString() );
});
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
if(cameraController.value.isInitialized){
 // Navigate to a different page
}
else{
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
                    Icon(Icons.power_settings_new, size: 40, color: Colors.blueGrey.shade500),
                    const SizedBox(height: 4),
                    Text("Start", style: TextStyle(color: Colors.blueGrey.shade500 ,fontSize: 25),)
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