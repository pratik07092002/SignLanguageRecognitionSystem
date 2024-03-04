import 'package:app/Information/Letters.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
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
        ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> LettersImage() ));
          },
          title : Text("Letters" , style: TextStyle(color: Colors.white , fontSize: 25),),
          leading: Icon(Icons.abc ,color: Colors.white, size: 40,),
          trailing: Icon(Icons.menu_book , color: Colors.white,),
          tileColor: Colors.black,
          
        ),
        Divider(color: Colors.blueGrey,),
        ListTile(
          onTap: (){},
          title : Text("Words" , style: TextStyle(color: Colors.white , fontSize: 25),),
          leading: Icon(Icons.wordpress_outlined ,color: Colors.white, size: 40,),
          trailing: Icon(Icons.menu_book , color: Colors.white,),
          tileColor: Colors.black,
        ),
        Divider(color: Colors.blueGrey,),

      ],)),
    );
  }
}