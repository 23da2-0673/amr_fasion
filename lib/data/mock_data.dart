import '../models/product.dart';

class MockData {
  static final List<Product> menProducts = [
    Product(
      id: 'men1',
      name: 'Premium Chinese pant',
      category: 'men',
      price: 129.99,
      imageUrl:
          'assets/images/image3.webp',
      description: 'A stylish chinese pant for everyday wear.',
      colors: ['Black', 'Blue'],
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'men2',
      name: 'Mens Puffer Jacket',
      category: 'men',
      price: 159.99,
      imageUrl:
          'assets/images/image2.jpg',
      description: 'Comfortable puffer jacket for cold weather.',
      colors: ['Navy', 'Khaki'],
      sizes: ['S', 'M', 'L', 'XL'],
    ),
  ];

  static final List<Product> womenProducts = [
    Product(
      id: 'women1',
      name: 'Premium Cotton Pant',
      category: 'women',
      price: 79.99,
      imageUrl:
          'assets/images/image9.webp',
      description: 'Lightweight dress perfect for sunny days.',
      colors: ['Pink', 'White'],
      sizes: ['XS', 'S', 'M', 'L'],
    ),
    Product(
      id: 'women2',
      name: 'Linen Shirt',
      category: 'women',
      price: 99.99,
      imageUrl:
          'assets/images/image7.webp',
      description: 'Classic linen shirt with a relaxed fit.',
      colors: ['Blue', 'Black'],
      sizes: ['S', 'M', 'L'],
    ),
  ];

  static final List<Product> kidsProducts = [
    Product(
      id: 'kids1',
      name: 'Kids Hoodie',
      category: 'kids',
      price: 59.99,
      imageUrl:
          'assets/images/image13.webp',
      description: 'Comfortable hoodie for active kids.',
      colors: ['Red', 'Blue'],
      sizes: ['XS', 'S', 'M'],
    ),
    Product(
      id: 'kids2',
      name: 'BABY GIRL SLEEVELESS OCCASION DRESS',
      category: 'kids',
      price: 49.99,
      imageUrl:
          'assets/images/image12.jpg',
      description: 'Dress for special occasions.',
      colors: ['White', 'Black'],
      sizes: ['XS', 'S', 'M'],
    ),
  ];

  static final List<Product> beautyProducts = [
    Product(
      id: 'beauty1',
      name: 'Saffron Face Wash',
      category: 'beauty',
      price: 89.99,
      imageUrl:
          'assets/images/image15.webp',
      description: 'A natural face wash infused with saffron for a radiant complexion.',
      colors: ['Clear'],
      sizes: ['50ml', '100ml'],
    ),
    Product(
      id: 'beauty2',
      name: 'Classic Nail Polish',
      category: 'beauty',
      price: 29.99,
      imageUrl:
          'assets/images/image16.webp',
      description: 'Classic nail polish in a vibrant shade.',
      colors: ['White'],
      sizes: ['100ml'],
    ),
  ];
}
