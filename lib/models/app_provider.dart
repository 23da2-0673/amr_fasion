import 'package:flutter/foundation.dart';
import 'product.dart';

class AppProvider extends ChangeNotifier {
  // Auth state
  bool _isLoggedIn = false;
  String _userName = '';
  String _userEmail = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;

  void login(String email, String password) {
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
  }

  void register(String name, String email, String password) {
    _isLoggedIn = true;
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = '';
    _userEmail = '';
    notifyListeners();
  }

  // Cart management
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  double get cartTotal =>
      _cartItems.fold(0, (sum, item) => sum + item.total);

  int get cartCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(Product product, String size, String color) {
    final existing = _cartItems.where((i) =>
        i.product.id == product.id &&
        i.selectedSize == size &&
        i.selectedColor == color);
    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      _cartItems.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int qty) {
    if (qty <= 0) {
      _cartItems.removeAt(index);
    } else {
      _cartItems[index].quantity = qty;
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Wishlist management
  final List<WishlistItem> _wishlist = [];
  List<WishlistItem> get wishlist => _wishlist;

  bool isWishlisted(String productId) =>
      _wishlist.any((w) => w.product.id == productId);

  void toggleWishlist(Product product, String size, String color) {
    if (isWishlisted(product.id)) {
      _wishlist.removeWhere((w) => w.product.id == product.id);
    } else {
      _wishlist.add(WishlistItem(product: product, size: size, color: color));
    }
    notifyListeners();
  }
}
