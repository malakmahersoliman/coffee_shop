import 'package:coffeetute/models/coffee.dart';
import 'package:coffeetute/models/coffee_shop.dart';
import 'package:coffeetute/components/coffee_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  void addToCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).addItemToCart(coffee);

    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Successfully added to cart"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Text(
                "How would you like your coffee?",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: value.coffeeShop.length,
                  itemBuilder: (context, index) {
                    Coffee eachCoffee = value.coffeeShop[index];
                    return CoffeeTitle(
                      coffee: eachCoffee,
                      price: eachCoffee.price,
                      onAdd: () => addToCart(eachCoffee),
                      onIncrement: () {}, // not needed in shop page
                      onDecrement: () {}, // not needed in shop page
                      isInCart: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
