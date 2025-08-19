// import 'package:flutter/material.dart';

// class CustomFormTextField extends StatelessWidget {
//   const CustomFormTextField({
//     Key? key,
//     this.hintText,
//     this.onChanged,
//     this.obscureText = false,
//     required this.controller,
//   }) : super(key: key);

//   final Function(String)? onChanged;
//   final String? hintText;
//   final bool obscureText;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       validator: (data) {
//         if (data!.isEmpty) {
//           return 'field is required';
//         }
//         return null;
//       },
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: Colors.white),
//         enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//         border: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    required this.controller,
  });

  final Function(String)? onChanged;
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.073,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required';
          }
          return null;
        },
        onChanged: onChanged,
        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.043),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.043,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.015,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
        ),
      ),
    );
  }
}
