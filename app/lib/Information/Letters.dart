import 'package:flutter/material.dart';

class LettersImage extends StatefulWidget {
  const LettersImage({super.key});

  @override
  State<LettersImage> createState() => _LettersImageState();
}

class _LettersImageState extends State<LettersImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
     
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bodypage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Center(
            child: Container(
              width: 600,
              height: 500, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Letters.webp'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
