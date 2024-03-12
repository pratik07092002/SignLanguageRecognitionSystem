import 'package:app/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraOpen extends StatefulWidget {
  final CameraController cam;
  const CameraOpen({super.key , required this.cam});

  @override
  State<CameraOpen> createState() => _CameraOpenState();
}

class _CameraOpenState extends State<CameraOpen> {

  @override
  Widget build(BuildContext context) {
    screensize = MediaQuery.of(context).size;
    return Scaffold(
      
      body: SafeArea(child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/menubar.jpg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Predicted Letter" ,style: TextStyle(color: Colors.white),),
SizedBox(height: 15,),
            Text("Confidence Value" , style: TextStyle(color: Colors.white)),
           Expanded(
             child: Container(
              height: screensize.height *0.50, 
              width: screensize.width,
              child: CameraPreview(widget.cam),
             ),
           )
          ],
        ),
      )),
    );
  }
}