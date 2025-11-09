import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../providers/cart_provider.dart';

class BookDetailPage extends StatefulWidget {
  final Map<String, dynamic> book;
  final int bookIndex;

  const BookDetailPage({
    super.key,
    required this.book,
    required this.bookIndex,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF8a5bf7)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Book Details',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover Image with Fade Animation
            FadeTransition(
              opacity: _fadeController,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 24 : 32),
                child: Center(
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _slideController,
                            curve: Curves.easeOut,
                          ),
                        ),
                    child: Container(
                      width: isMobile ? 200 : 280,
                      height: isMobile ? 300 : 420,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF8a5bf7,
                            ).withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              widget.book['image'] ??
                                  'assets/images/The Great Gatsby.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF8a5bf7),
                                        const Color(0xFF7c4de6),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.auto_stories,
                                      size: isMobile ? 80 : 120,
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Decorative badge
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '★ 4.8',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF8a5bf7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Book Title, Author, Category with Fade
            FadeTransition(
              opacity: _fadeController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 16 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book['title'],
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF8a5bf7),
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    Text(
                      'by ${widget.book['author']}',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8a5bf7),
                      ),
                    ),
                    SizedBox(height: isMobile ? 12 : 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8a5bf7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Fiction',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Star Rating and Reviews with Fade
            FadeTransition(
              opacity: _fadeController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32),
                child: Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (starIndex) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.star,
                            size: isMobile ? 18 : 20,
                            color: starIndex < 4
                                ? Colors.amber
                                : Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 12 : 16),
                    Text(
                      '4.8 (324 reviews)',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 13 : 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8a5bf7),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: isMobile ? 20 : 28),

            // Book Description with Fade
            FadeTransition(
              opacity: _fadeController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8a5bf7),
                      ),
                    ),
                    SizedBox(height: isMobile ? 12 : 16),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: isMobile ? 150 : 200,
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          'This compelling novel follows the life and times of a fascinating protagonist through a journey of self-discovery, adventure, and profound personal growth. '
                          'With beautifully crafted prose and deeply developed characters, this masterpiece captivates readers from the first page to the last. '
                          'The author explores themes of love, ambition, identity, and redemption in a way that resonates with readers across generations. '
                          'This is a must-read for anyone seeking an immersive and transformative literary experience. '
                          'Perfect for book club discussions and long-term reflection.',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 13 : 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: isMobile ? 24 : 32),

            // Price and Add to Cart Button with Fade
            FadeTransition(
              opacity: _fadeController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 16 : 24,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 12 : 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF8a5bf7),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${widget.book['price'].toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 24 : 28,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF8a5bf7),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            final cartProvider = Provider.of<CartProvider>(
                              context,
                              listen: false,
                            );
                            final cartItem = CartItem(
                              id: 'book_${widget.bookIndex}',
                              title: widget.book['title'],
                              author: widget.book['author'],
                              price: widget.book['price'],
                              image:
                                  widget.book['image'] ??
                                  'assets/images/The Great Gatsby.jpg',
                              quantity: 1,
                            );
                            cartProvider.addItem(cartItem);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${widget.book['title']} added to cart!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: const Color(
                                  0xFF81C784,
                                ), // Light green
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(isMobile ? 16 : 24),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8a5bf7),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 20 : 24,
                              vertical: isMobile ? 14 : 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: Text(
                            'Add to Cart',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 13 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 16 : 20),
                    // Additional Info
                    Container(
                      padding: EdgeInsets.all(isMobile ? 16 : 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF8a5bf7,
                            ).withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            isMobile,
                            Icons.language,
                            'Language',
                            'English',
                          ),
                          SizedBox(height: isMobile ? 12 : 16),
                          _buildInfoRow(isMobile, Icons.pages, 'Pages', '324'),
                          SizedBox(height: isMobile ? 12 : 16),
                          _buildInfoRow(
                            isMobile,
                            Icons.calendar_today,
                            'Published',
                            '2020',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: isMobile ? 24 : 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    bool isMobile,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: isMobile ? 18 : 20,
              color: const Color(0xFF8a5bf7),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 13 : 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8a5bf7),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF8a5bf7),
          ),
        ),
      ],
    );
  }
}
