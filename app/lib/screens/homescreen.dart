import 'package:flutter/material.dart';

class SLRhomePage extends StatefulWidget {
  const SLRhomePage({super.key});

  @override
  State<SLRhomePage> createState() => _SLRhomePageState();
}

class _SLRhomePageState extends State<SLRhomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(children: [
            Text("Sign", style: TextStyle(color: Colors.black),),
            Text("Language",style: TextStyle(color: Colors.red),)
          ],),
        ),
      ),
    );
  }
}