import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  const customTextField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return  Container(
      width: size.width*0.8, 
      decoration: BoxDecoration(
        color: Colors.grey[200], // Off-white color
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
