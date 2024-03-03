import 'package:app/drawer/menudrawer.dart';
import 'package:app/screens/homescreenbody.dart';
import 'package:flutter/material.dart';

class SLRhomePage extends StatefulWidget {
  const SLRhomePage({super.key});

  @override
  State<SLRhomePage> createState() => _SLRhomePageState();
}

class _SLRhomePageState extends State<SLRhomePage> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      key: scaffoldkey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.black,
        title: Container(
          child: Row(children: [
           
            Text("Sign", style: TextStyle(color: Colors.blueGrey),),
            Text("Language",style: TextStyle(color: Colors.blue),)
          ],),
        ),
        leading: IconButton(onPressed: (){
          scaffoldkey.currentState?.openDrawer();
        }, icon: Icon(Icons.menu)),
      ),
      drawer: MenuDrawer(),
      body: HomeScreenBody(),

    );
  }
}