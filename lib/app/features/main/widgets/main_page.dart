import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100, 
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage('img/logo.jpeg'), // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
