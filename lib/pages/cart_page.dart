import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import '../providers/cart_provider.dart';
import '../services/checkout_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  late List<AnimationController> _itemAnimationControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    // Dispose existing controllers if they exist
    for (var controller in _itemAnimationControllers) {
      controller.dispose();
    }
    _itemAnimationControllers = List.generate(
      cartProvider.items.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 500 + (index * 100)),
        vsync: this,
      ),
    );

    for (var controller in _itemAnimationControllers) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _itemAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(CartPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initializeAnimations();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Cart Content
              Expanded(child: _buildCartContent(cartProvider, isMobile)),

              // Bottom Section with Total and Checkout
              if (cartProvider.items.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(isMobile ? 16 : 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildPriceRow(
                        'Subtotal',
                        '\$${cartProvider.subtotal.toStringAsFixed(2)}',
                        isMobile,
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      _buildPriceRow(
                        'Tax (8%)',
                        '\$${cartProvider.tax.toStringAsFixed(2)}',
                        isMobile,
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      _buildPriceRow(
                        'Total',
                        '\$${cartProvider.total.toStringAsFixed(2)}',
                        isMobile,
                        isTotal: true,
                      ),
                      SizedBox(height: isMobile ? 16 : 20),
                      // Checkout button
                      SizedBox(
                        width: double.infinity,
                        height: isMobile ? 50 : 56,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (cartProvider.items.isEmpty) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Your cart is empty'),
                                    backgroundColor: Color(
                                      0xFF81C784,
                                    ), // Light green
                                  ),
                                );
                              }
                              return;
                            }

                            print(
                              '🛒 Checkout started. Items: ${cartProvider.items.length}',
                            );
                            print('💰 Total: ${cartProvider.total}');

                            // Show loading
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            try {
                              print('📡 Creating payment intent...');
                              // Create payment intent
                              final paymentResult =
                                  await CheckoutService.createPaymentIntent(
                                    amount: cartProvider.total,
                                    currency: 'usd',
                                    items: cartProvider.items
                                        .map(
                                          (item) => {
                                            'id': item.id,
                                            'title': item.title,
                                            'quantity': item.quantity,
                                            'price': item.price,
                                          },
                                        )
                                        .toList(),
                                  );

                              print(
                                '✅ Payment result received: ${paymentResult['success']}',
                              );

                              if (!context.mounted) return;
                              Navigator.pop(context); // Close loading dialog

                              if (paymentResult['success']) {
                                print('✅ Payment intent created successfully');
                                final clientSecret =
                                    paymentResult['data']['client_secret'];

                                print('🎯 Presenting payment sheet...');
                                // Present payment sheet
                                final paymentSuccess =
                                    await CheckoutService.presentPaymentSheet(
                                      context,
                                      clientSecret: clientSecret,
                                      amount: cartProvider.total,
                                      items: cartProvider.items
                                          .map(
                                            (item) => {
                                              'id': item.id,
                                              'title': item.title,
                                              'quantity': item.quantity,
                                              'price': item.price,
                                            },
                                          )
                                          .toList(),
                                    );

                                if (paymentSuccess && context.mounted) {
                                  print('💳 Payment successful!');
                                  // Clear cart and show success
                                  cartProvider.clearCart();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Payment successful! Thank you for your purchase.',
                                      ),
                                      backgroundColor: Color(
                                        0xFF81C784,
                                      ), // Light green
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  // Navigate to homepage and clear navigation stack
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                                } else {
                                  print('❌ Payment sheet returned false');
                                }
                              } else {
                                print(
                                  '❌ Payment intent creation failed: ${paymentResult['error']}',
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Payment failed: ${paymentResult['error']}',
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 4),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              print('❌ Checkout exception: $e');
                              if (!context.mounted) return;
                              Navigator.pop(context); // Close loading dialog
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Payment error: $e'),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8a5bf7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 14 : 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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
      ),
    );
  }

  Widget _buildCartContent(CartProvider cartProvider, bool isMobile) {
    if (cartProvider.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: isMobile ? 80 : 100,
              color: Colors.grey[400],
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Text(
              'Your cart is empty',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              'Add some books to get started!',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: isMobile ? 24 : 32),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8a5bf7),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 12 : 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Browse Books',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      itemCount: cartProvider.items.length,
      itemBuilder: (context, index) {
        final item = cartProvider.items[index];
        final animationController = _itemAnimationControllers[index];

        return AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - animationController.value)),
              child: Opacity(opacity: animationController.value, child: child),
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: isMobile ? 12 : 16),
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Book Image
                Container(
                  width: isMobile ? 60 : 80,
                  height: isMobile ? 80 : 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: isMobile ? 12 : 16),

                // Book Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8a5bf7),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 4 : 6),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8a5bf7),
                        ),
                      ),
                    ],
                  ),
                ),

                // Quantity Controls
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        final index = cartProvider.items.indexWhere(
                          (i) => i.id == item.id,
                        );
                        if (index != -1) {
                          cartProvider.updateQuantity(index, item.quantity - 1);
                        }
                      },
                      icon: const Icon(Icons.remove),
                      color: const Color(0xFF8a5bf7),
                      iconSize: isMobile ? 20 : 24,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 8 : 12,
                        vertical: isMobile ? 4 : 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8a5bf7),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final index = cartProvider.items.indexWhere(
                          (i) => i.id == item.id,
                        );
                        if (index != -1) {
                          cartProvider.updateQuantity(index, item.quantity + 1);
                        }
                      },
                      icon: const Icon(Icons.add),
                      color: const Color(0xFF8a5bf7),
                      iconSize: isMobile ? 20 : 24,
                    ),
                  ],
                ),

                // Remove Button
                IconButton(
                  onPressed: () => cartProvider.removeItemById(item.id),
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red[400],
                  iconSize: isMobile ? 20 : 24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount,
    bool isMobile, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 12 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? const Color(0xFF8a5bf7) : const Color(0xFF8a5bf7),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 12 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            color: const Color(0xFF8a5bf7),
          ),
        ),
      ],
    );
  }
}
