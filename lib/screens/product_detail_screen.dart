import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/app_provider.dart';
import '../models/product.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String selectedColor;
  late String selectedSize;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.product.colors.isNotEmpty
        ? widget.product.colors.first
        : 'Black';
    selectedSize = widget.product.sizes.isNotEmpty
        ? widget.product.sizes.first
        : 'M';
  }

  Color _parseColor(String value) {
    if (value.startsWith('#')) {
      final hex = value.replaceFirst('#', '');
      final colorInt = int.parse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
      return Color(colorInt);
    }
    switch (value.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'red':
        return Colors.red;
      case 'pink':
        return Colors.pink;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isWishlisted = provider.isWishlisted(widget.product.id);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => provider.toggleWishlist(
                      widget.product,
                      selectedSize,
                      selectedColor,
                    ),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isWishlisted
                            ? const Color(0xFFFDECEA)
                            : const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted ? const Color(0xFFE53935) : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: AspectRatio(
                          aspectRatio: 4 / 5,
                          child: Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: const Color(0xFFF2F2F2),
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    size: 60, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.6,
                                color: const Color(0xFF0D0D0D),
                              ),
                            ),
                          ),
                          Text(
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D0D0D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        widget.product.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          height: 1.7,
                          color: const Color(0xFF4A4A4A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Colors',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D0D0D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: widget.product.colors.map((color) {
                          final parsed = _parseColor(color);
                          final isSelected = selectedColor == color;
                          return GestureDetector(
                            onTap: () => setState(() => selectedColor = color),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: parsed,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF0D0D0D)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check,
                                      size: 18, color: Colors.white)
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Size',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D0D0D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: widget.product.sizes.map((size) {
                          final isSelected = selectedSize == size;
                          return GestureDetector(
                            onTap: () => setState(() => selectedSize = size),
                            child: Container(
                              width: 62,
                              height: 44,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black
                                    : const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                size,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: const Color.fromRGBO(128, 128, 128, 0.15),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: const Color(0xFF0D0D0D),
                      onPressed: () => provider.toggleWishlist(
                        widget.product,
                        selectedSize,
                        selectedColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AppProvider>().addToCart(
                                widget.product,
                                selectedSize,
                                selectedColor,
                              );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          'ADD TO CART',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
