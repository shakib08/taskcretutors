import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final String hintText;
  final VoidCallback onClick;
  const customButton({ Key? key,
    required this.hintText,
    required this.onClick,}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[800], // Dark blue background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded rectangle shape
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      ),
      onPressed: onClick,
      child: Text(
        hintText,
        style: const TextStyle(
          color: Colors.white, // White text color
          fontSize: 16.0,
        ),
      ),
    );
  }
}