import 'package:flutter/material.dart';
import 'coffee.dart';
import 'package:coffeetute/database/db_helper.dart'; 
class CoffeeShop extends ChangeNotifier {

  final List<Coffee> _coffeeShop = [
    Coffee(
      name: 'Long Black', 
      price: 4.10, 
      imagePath: "lib/images/black.png"
      ),
    Coffee(
      name: 'Latte', 
      price: 4.20, 
      imagePath: "lib/images/latte.png"
      ),
    Coffee(
      name: 'Espresso Shot', 
      price: 3.50, 
      imagePath: "lib/images/espresso.png"
      ),
    Coffee(
      name: 'Iced Coffee', 
      price: 4.40, 
      imagePath: "lib/images/iced_coffee.png"
      ),
  ];

  
  final List<Coffee> _userCart = [];

  List<Coffee> get coffeeShop => _coffeeShop;
  List<Coffee> get userCart => _userCart;


  void addItemToCart(Coffee coffee) async {
  
    int index = userCart.indexWhere((c) => c.name == coffee.name);
    if (index != -1) {

      userCart[index].quantity++;
      await DatabaseHelper().updateCoffee(userCart[index]); 
    } else {
   
      userCart.add(coffee);

      
      int id = await DatabaseHelper().insertCoffee(coffee);
      coffee.id = id; 
      notifyListeners(); 
    }
  }

  void removeItemFromCart(Coffee coffee) async {
    int index = userCart.indexWhere((c) => c.name == coffee.name);
    if (index != -1) {
      
      userCart[index].quantity--;
      if (userCart[index].quantity <= 0) {
        
        await DatabaseHelper().deleteCoffee(coffee.id!);
        userCart.removeAt(index); 
      } else {
        await DatabaseHelper().updateCoffee(userCart[index]); 
      }
    }
    notifyListeners(); 
  }
}