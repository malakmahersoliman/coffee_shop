import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // To preserve gradient
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        splashColor: Colors.white24,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown.shade700, Colors.brown.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.brown,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}