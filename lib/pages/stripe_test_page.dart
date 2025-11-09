import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/checkout_service.dart';

class StripeTestPage extends StatelessWidget {
  const StripeTestPage({super.key});

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Stripe Test Cards',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Card Numbers',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8a5bf7),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              'Use any future expiry date and any 3-digit CVC',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                color: const Color(0xFF8a5bf7),
              ),
            ),
            SizedBox(height: isMobile ? 24 : 32),
            _buildTestCard(
              'Success Card',
              CheckoutService.getTestCardInfo('success'),
              Colors.green,
              isMobile,
            ),
            SizedBox(height: isMobile ? 16 : 20),
            _buildTestCard(
              'Declined Card',
              CheckoutService.getTestCardInfo('declined'),
              Colors.red,
              isMobile,
            ),
            SizedBox(height: isMobile ? 16 : 20),
            _buildTestCard(
              'Authentication Required',
              CheckoutService.getTestCardInfo('requires_auth'),
              Colors.orange,
              isMobile,
            ),
            SizedBox(height: isMobile ? 32 : 40),
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚠️ Important Notes',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: isMobile ? 8 : 12),
                  Text(
                    '• Replace the test keys in checkout_service.dart with your actual Stripe test keys\n'
                    '• This is for testing only - never use test keys in production\n'
                    '• Payment intents should be created on your backend in production\n'
                    '• Test payments don\'t process real money',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 12 : 14,
                      color: Colors.blue[700],
                      height: 1.5,
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

  Widget _buildTestCard(
    String title,
    String cardInfo,
    Color color,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 12 : 16,
            height: isMobile ? 12 : 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF8a5bf7),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  cardInfo,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8a5bf7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

