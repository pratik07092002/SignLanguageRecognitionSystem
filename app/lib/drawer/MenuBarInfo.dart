import 'package:flutter/material.dart';

class MenuBarInfo extends StatefulWidget {
  const MenuBarInfo({super.key});

  @override
  State<MenuBarInfo> createState() => _MenuBarInfoState();
}

class _MenuBarInfoState extends State<MenuBarInfo> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      
              child: Column(
                children: [
                   ListTile(
              title: Text("About" , style: TextStyle(color: Colors.white , fontSize: 21),),
        
            ),
            ListTile(title: Text("Signs Info" , style: TextStyle(color: Colors.white , fontSize: 21),) )
                ],
              ),
            );
  }
}