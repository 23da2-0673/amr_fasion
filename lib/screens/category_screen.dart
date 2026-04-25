import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/product.dart';
import '../models/app_provider.dart';
import 'product_detail_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  final String label;

  const CategoryScreen(
      {super.key, required this.category, required this.label});

  List<Product> _getProducts() {
    switch (category) {
      case 'men':
        return MockData.menProducts;
      case 'women':
        return MockData.womenProducts;
      case 'kids':
        return MockData.kidsProducts;
      case 'beauty':
        return MockData.beautyProducts;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _getProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, size: 24),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                label,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D0D0D),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                  children: products.map((product) {
                    return _ProductTile(product: product);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;
  const _ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isWished = provider.isWishlisted(product.id);

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (_, _, _) =>
                        Container(color: const Color(0xFFDDDDDD)),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => provider.toggleWishlist(
                        product,
                        product.sizes.isNotEmpty ? product.sizes.first : 'M',
                        product.colors.isNotEmpty
                            ? product.colors.first
                            : 'Black'),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isWished ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: isWished
                            ? const Color(0xFFE53935)
                            : const Color(0xFF888888),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0D0D0D)),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
                fontSize: 11, color: const Color(0xFF4A4A4A)),
          ),
        ],
      ),
    );
  }
}
