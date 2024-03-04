import 'package:flutter/material.dart';

class ConnectionButton extends StatelessWidget {
  const ConnectionButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            
            child: Material(
              elevation: 4,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: 150, 
                height: 150, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyan.shade100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.power_settings_new, size: 40, color: Colors.blueGrey.shade500),
                    const SizedBox(height: 4),
                    Text("Start", style: TextStyle(color: Colors.blueGrey.shade500 ,fontSize: 25),)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
