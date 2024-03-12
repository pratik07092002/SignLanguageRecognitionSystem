import 'dart:io';

//import 'package:app/ConnectButton/ConnectionButton.dart';
import 'package:app/serverconnect/function.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
    File? ImageFile;
  String Predicted_char = "";
  Future<void> SelectImage() async{
var picker = ImagePicker();
final pickedimg = await picker.pickImage(source: ImageSource.gallery);

setState(() {
  if (pickedimg != null) {
  ImageFile = File(pickedimg.path);
}
else{
  Fluttertoast.showToast(msg: "no image selected");
}
});
  }

Future<void> _SendImage() async {
  if (ImageFile != null) {
    try {
      String predictedChar = (await sendImage(ImageFile!));

      // Update the state with the predicted character
      setState(() {
        Predicted_char = predictedChar.toString();
      });

    } catch (e) {
      Fluttertoast.showToast(msg: "Error in UI: $e");
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bodypage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            
            children: [
              SizedBox(height: 40,),
             Text("Bridging the Gap" , style: TextStyle(fontSize: 34, color: Colors.blueGrey.shade300),),
             
             SizedBox(height: 10,),
            // ConnectionButton()
             
          // selected image display 
        Container(
          decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            color: Colors.white
            
          ),
          height: 400,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: ImageFile == null ? Text(" NO Image Selected" ,) : Image.file(ImageFile!)),
            ],
          ),
        ),
        SizedBox(height: 120,),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           ElevatedButton(
              style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black)
          ),
              onPressed: SelectImage, child: Text("Select Image" , style: TextStyle(color: Colors.blueGrey),)),
        SizedBox(width: 10,),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black)
          ),
          onPressed: _SendImage, child: Text("Send Image" ,  style: TextStyle(color: Colors.blueGrey))),
        ],
       ),
          
      SizedBox(height: 10,)
      ,
      Container(
        padding: EdgeInsets.all(18),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.blueGrey),
        color: Colors.black,
        ),
        child: Text("Predicted Letter:-: ${Predicted_char}" , style: TextStyle(color: Colors.blueGrey),))

                  
                
            
             
            ],
          ),
        ),
      ),
    );
  }
}
