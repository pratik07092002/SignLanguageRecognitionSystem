import 'package:app/drawer/MenuBarInfo.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        
          child: Container(
            padding: EdgeInsets.all(3),
            decoration :BoxDecoration(color: Colors.blueGrey),
            child: ListView(
              
              children: [
                DrawerHeader(decoration: BoxDecoration(
                  
                ),
            
                child: Text('DrawerHeader'),
                ),
                
               MenuBarInfo()
               
              ],
            ),
          ),
        
      );
    
  }
}