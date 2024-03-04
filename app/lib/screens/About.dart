import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(children: [Text("Info" , style: TextStyle(color: Colors.blue),)],),
       backgroundColor: Colors.black,
       iconTheme: IconThemeData(color: Colors.blueGrey),
       ),
       
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/bodypage.jpg'), 
        fit: BoxFit.cover
        )),
        child: Column(children: [
          Text("Guided by :-" , style: TextStyle(color: Colors.white , fontSize: 20),),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Prof. Poonam Patil" , style: TextStyle(color: Colors.white , fontSize: 30),)
        ],
       ),
       SizedBox(height: 45,),
       Text("Group Members :-" , style: TextStyle(color: Colors.white, fontSize: 20),),
       SizedBox(height: 20,),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Pratik Gaikwad" , style: TextStyle(color: Colors.white , fontSize: 20),) ,
          SizedBox(width: 50,),
          Text("Samiksha Gawande" , style: TextStyle(color: Colors.white , fontSize: 20),)

        ],
       ),
       SizedBox(height: 25,),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Yash Gaikwad" , style: TextStyle(color: Colors.white , fontSize: 20),) ,
          SizedBox(width: 50,),
          Text("Prathamesh Shinde" , style: TextStyle(color: Colors.white , fontSize: 20),)

        ],
       )

      ],)),
    );
  }
}