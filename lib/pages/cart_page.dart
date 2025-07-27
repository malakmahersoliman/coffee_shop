import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeetute/models/coffee.dart';
import 'package:coffeetute/models/coffee_shop.dart';
import 'package:coffeetute/components/coffee_title.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) {
        // Calculate total price
        double totalPrice = value.userCart.fold(0.0, (sum, coffee) {
          // Convert price to double if it's a string
          double price = coffee.price ;
          // Multiply price by quantity
          return sum + (price * coffee.quantity);
        });


        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const Text('Your Cart', style: TextStyle(fontSize: 20)),
                value.userCart.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('Your cart is empty!', style: TextStyle(fontSize: 16)),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: value.userCart.length,
                          itemBuilder: (context, index) {
                            Coffee eachCoffee = value.userCart[index];

                            return CoffeeTitle(
                              coffee: eachCoffee,
                              price: eachCoffee.price * eachCoffee.quantity,
                              onAdd: () {}, // Not needed in the cart
                              onIncrement: () => value.addItemToCart(eachCoffee),
                              onDecrement: () => value.removeItemFromCart(eachCoffee),
                              isInCart: true,
                            );
                          },
                        ),
                      ),
                // Display total and pay button if cart is not empty
                if (value.userCart.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Text('Total: \$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle pay logic here
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Pay'),
                              content: const Text('Proceeding to payment...'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 10, // Shadow effect
                        ).copyWith(
                          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (states) {
                              if (states.contains(WidgetState.pressed)) {
                                return Colors.brown.withAlpha((0.8 * 255).round()); // Darker shade when pressed
                              }
                              return Colors.brown;
                            },
                          ),
                        ),
                        child: const Text(
                          'Pay Now',
                          style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold,
                            ),
                        
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

