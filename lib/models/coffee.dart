class Coffee {
  int? id; 
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  Coffee({
    this.id, 
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'quantity': quantity,
    };
  }
}