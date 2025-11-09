import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartIconWithBadge extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isSelected;

  const CartIconWithBadge({super.key, this.onPressed, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final totalQuantity = cartProvider.totalQuantity;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: Icon(
                isSelected ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                color: const Color(0xFF8a5bf7),
              ),
              onPressed: onPressed,
            ),
            if (totalQuantity > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    totalQuantity > 99 ? '99+' : totalQuantity.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

