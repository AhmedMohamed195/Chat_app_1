
import 'package:chat_app_1/features/data/models/message.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
  
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, 
          vertical: screenHeight * 0.02, 
        ).copyWith(left: screenWidth * 0.04), 
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, 
          vertical: screenHeight * 0.01,  
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.08),   
            topRight: Radius.circular(screenWidth * 0.08),
            bottomRight: Radius.circular(screenWidth * 0.08),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.04, 
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, 
          vertical: screenHeight * 0.02,  
        ).copyWith(left: screenWidth * 0.04),
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, 
          vertical: screenHeight * 0.01, 
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.08),
            topRight: Radius.circular(screenWidth * 0.08),
            bottomLeft: Radius.circular(screenWidth * 0.08),
          ),
          color: const Color(0xff006D84),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
