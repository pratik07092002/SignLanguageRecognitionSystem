import 'package:flutter/material.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
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
              SizedBox(height: 60,),
             Text("Bridging the Gap" , style: TextStyle(fontSize: 34, color: Colors.blueGrey.shade300),),
             // Button for Opening the Video Loop
             SizedBox(height: 20,)
                  
                
            
             
            ],
          ),
        ),
      ),
    );
  }
}
