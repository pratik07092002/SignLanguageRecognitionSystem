import 'package:app/screens/About.dart';
import 'package:app/screens/info.dart';
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
                    },
              title: Text("About" , style: TextStyle(color: Colors.white , fontSize: 21),
              
              ),
        
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InformationPage()));
              },
              title: Text("Signs Info" , style: TextStyle(color: Colors.white , fontSize: 21),) )
                ],
              ),
            );
  }
}