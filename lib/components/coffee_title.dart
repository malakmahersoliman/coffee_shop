import 'package:flutter/material.dart';
import 'package:coffeetute/models/coffee.dart';

class CoffeeTitle extends StatelessWidget {
  final Coffee coffee;
   final double price;
  final VoidCallback onAdd;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool isInCart;

  const CoffeeTitle({
    super.key,
    required this.coffee,
    required this.price,
    required this.onAdd,
    required this.onIncrement,
    required this.onDecrement,
    required this.isInCart,
  });

  @override
  Widget build(BuildContext context) {
    // Convert price to double if it's a string
    double price = coffee.price ;
    double totalPrice = price * coffee.quantity; // Calculate total price based on quantity

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: Text(coffee.name),
        subtitle: Text("\$${totalPrice.toStringAsFixed(2)}"), // Displaying total price
        leading: Image.asset(coffee.imagePath),
        trailing: isInCart
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: onDecrement,
                  ),
                  Text(coffee.quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: onIncrement,
                  ),
                ],
              )
            : IconButton(
                icon: const Icon(Icons.add),
                onPressed: onAdd,
              ),
      ),
    );
  }
}