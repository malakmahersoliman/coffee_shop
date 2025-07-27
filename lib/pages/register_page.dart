import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeetute/components/button.dart';
import 'package:coffeetute/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordTextController.text != confirmPasswordTextController.text) {
      Navigator.pop(context);
      displayMessage("Passwords don't match!");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100], // Coffee-themed background
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Icon(
                  Icons.local_cafe, // Coffee icon
                  size: 100,
                  color: Colors.brown,
                ),
                const SizedBox(height: 50),
                // Create account message
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                // Email textfield
                MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscreText: false),
                const SizedBox(height: 10),
                // Password textfield
                MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscreText: true),
                const SizedBox(height: 10),
                // Confirm password textfield
                MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: 'Confirm Password',
                    obscreText: true),
                const SizedBox(height: 10),
                // Sign up button
                MyButton(
                  onTap: signUp,
                  text: 'Sign Up',
                ),
                const SizedBox(height: 10),
                // Go to login page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.brown[700],
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange, // Coffee-themed color
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
