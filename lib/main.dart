import 'package:coffeetute/models/coffee_shop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeetute/auth/auth.dart'; 
import 'package:coffeetute/firebase_options.dart'; 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoffeeShop(), 
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
