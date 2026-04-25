import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/category_screen.dart';
import 'screens/track_order_screen.dart';
import 'models/product.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const AmrFashionApp(),
    ),
  );
}

class AmrFashionApp extends StatelessWidget {
  const AmrFashionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AMR Fashion',
      theme: AppTheme.theme,
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/track-order': (context) => const TrackOrderScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          );
        }
        if (settings.name?.startsWith('/category/') ?? false) {
          final category = settings.name!.replaceFirst('/category/', '');
          final categoryLabel = _getCategoryLabel(category);
          return MaterialPageRoute(
            builder: (_) => CategoryScreen(
              category: category,
              label: categoryLabel,
            ),
          );
        }
        return null;
      },
    );
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'men':
        return 'Men';
      case 'women':
        return 'Women';
      case 'kids':
        return 'Kids';
      case 'beauty':
        return 'Beauty';
      default:
        return 'Products';
    }
  }
}
