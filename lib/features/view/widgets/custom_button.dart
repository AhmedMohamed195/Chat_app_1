
import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  const CustomButon({super.key, this.onTap, required this.text});

  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
 
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.02), 
        ),
        width: double.infinity,
        height: screenHeight * 0.07, 
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.045, 
              color: Colors.black,
             
            ),
          ),
        ),
      ),
    );
  }
}
