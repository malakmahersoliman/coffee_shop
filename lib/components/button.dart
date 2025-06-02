import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25), // Adjust padding
        decoration: BoxDecoration(
          gradient: LinearGradient( // Gradient for a more dynamic look
            colors: [Colors.brown.shade700, Colors.brown.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow( // Shadow for depth
              color: Colors.brown.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18, // Increased font size for better visibility
            ),
          ),
        ),
      ),
    );
  }
}
