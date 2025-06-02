import 'package:coffeetute/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:coffeetute/auth/auth.dart'; // Ensure AuthService is defined here
import 'package:coffeetute/components/bottom_nav_bar.dart';
import 'package:coffeetute/const.dart';
import 'package:coffeetute/pages/shop_page.dart';
import 'package:coffeetute/pages/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void NavigationBar(int index) {
    if (index == 2) { // Assuming index 2 is for logout
      _logout();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _logout() async {
    await AuthService().signOut(); // Sign out the user
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()), // Navigate to Auth page
    );
  }

  final List<Widget> _pages = [
    const ShopPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => NavigationBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
