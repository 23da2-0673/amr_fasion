class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String description;
  final List<String> colors;
  final List<String> sizes;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.colors = const [],
    this.sizes = const [],
  });
}

class CartItem {
  final Product product;
  int quantity;
  String selectedSize;
  String selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize = 'M',
    this.selectedColor = 'Black',
  });

  double get total => product.price * quantity;
}

class WishlistItem {
  final Product product;
  final String size;
  final String color;

  WishlistItem({
    required this.product,
    required this.size,
    required this.color,
  });
}
