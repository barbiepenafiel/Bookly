import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookstore/services/api_service.dart';
import 'stripe_test_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _avatarAnimationController;
  late AnimationController _contentAnimationController;
  late Animation<double> _avatarOpacity;
  late Animation<double> _contentOpacity;

  // User data from API
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  // Fallback data in case API fails
  final String defaultUserName = 'Barbie';
  final String defaultUserEmail = 'barbie@example.com';

  @override
  void initState() {
    super.initState();

    // Avatar animation
    _avatarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _avatarOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _avatarAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Content animation
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Load user profile data with a small delay to ensure token is stored
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadUserProfile();
    });

    // Start animations
    _avatarAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _contentAnimationController.forward();
    });
  }

  Future<void> _loadUserProfile() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // First check if we have a token
      final token = await ApiService.getToken();
      if (token == null) {
        // Use fallback data instead of showing error
        setState(() {
          _userData = {'name': defaultUserName, 'email': defaultUserEmail};
          _isLoading = false;
        });
        return;
      }

      final result = await ApiService.getProfile();

      if (result['success']) {
        setState(() {
          _userData = result['data'];
          _isLoading = false;
        });
      } else {
        // Use fallback data instead of showing error
        setState(() {
          _userData = {'name': defaultUserName, 'email': defaultUserEmail};
          _isLoading = false;
        });
      }
    } catch (e) {
      // Use fallback data instead of showing error
      setState(() {
        _userData = {'name': defaultUserName, 'email': defaultUserEmail};
        _isLoading = false;
      });
    }
  }

  // Getters for user data with fallbacks
  String get userName => _userData?['name'] ?? defaultUserName;
  String get userEmail => _userData?['email'] ?? defaultUserEmail;
  String get phoneNumber =>
      '+63 917 123 4567'; // Philippine phone number format

  @override
  void dispose() {
    _avatarAnimationController.dispose();
    _contentAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8a5bf7)),
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadUserProfile,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 24,
                    vertical: isMobile ? 16 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Avatar with Animation
                      FadeTransition(
                        opacity: _avatarOpacity,
                        child: Container(
                          width: isMobile ? 100 : 140,
                          height: isMobile ? 100 : 140,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF8a5bf7), Color(0xFF7c4de6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                              isMobile ? 50 : 70,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF8a5bf7,
                                ).withValues(alpha: 0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'B',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 32 : 48,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 20 : 30),

                      // User Name
                      FadeTransition(
                        opacity: _contentOpacity,
                        child: Text(
                          userName,
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 20 : 26,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF8a5bf7),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),

                      // Email
                      FadeTransition(
                        opacity: _contentOpacity,
                        child: Text(
                          userEmail,
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 13 : 15,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8a5bf7),
                          ),
                        ),
                      ),

                      // Phone Number
                      FadeTransition(
                        opacity: _contentOpacity,
                        child: Padding(
                          padding: EdgeInsets.only(top: isMobile ? 4 : 6),
                          child: Text(
                            phoneNumber,
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 13 : 15,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF8a5bf7),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: isMobile ? 24 : 32),

                      // Edit Profile Button
                      FadeTransition(
                        opacity: _contentOpacity,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8a5bf7),
                              padding: EdgeInsets.symmetric(
                                vertical: isMobile ? 12 : 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfilePage(),
                                ),
                              );
                            },
                            child: Text(
                              'Edit Profile',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 14 : 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: isMobile ? 28 : 36),

                      // Profile Menu Options
                      FadeTransition(
                        opacity: _contentOpacity,
                        child: Column(
                          children: _buildProfileOptions(context, isMobile),
                        ),
                      ),

                      SizedBox(height: isMobile ? 28 : 36),

                      // Version Info
                      FadeTransition(
                        opacity: _contentOpacity,
                        child: Text(
                          'Version 1.0.0',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 12 : 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(
                              0xFF8a5bf7,
                            ).withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  List<Widget> _buildProfileOptions(BuildContext context, bool isMobile) {
    final options = [
      {
        'icon': Icons.shopping_bag_outlined,
        'label': 'My Orders',
        'page': const OrdersPage(),
      },
      {
        'icon': Icons.favorite_outline,
        'label': 'Wishlist',
        'page': const WishlistPage(),
      },
      {
        'icon': Icons.payment,
        'label': 'Payment Methods',
        'page': const PaymentPage(),
      },
      {
        'icon': Icons.credit_card,
        'label': 'Stripe Test Cards',
        'page': const StripeTestPage(),
      },
      {
        'icon': Icons.tune_outlined,
        'label': 'Settings',
        'page': const SettingsPage(),
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help Center',
        'page': const HelpPage(),
      },
    ];

    return [
      ...options.map((option) {
        return Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
          child: Container(
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
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                leading: Icon(
                  option['icon'] as IconData,
                  color: const Color(0xFF8a5bf7),
                  size: isMobile ? 24 : 28,
                ),
                title: Text(
                  option['label'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8a5bf7),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: isMobile ? 16 : 18,
                  color: const Color(0xFF8a5bf7),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => option['page'] as Widget,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
      // Logout Option
      Padding(
        padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
        child: Container(
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
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: const Color(0xFFFF6B6B),
                size: isMobile ? 24 : 28,
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFFF6B6B),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: isMobile ? 16 : 18,
                color: const Color(0xFFFF6B6B),
              ),
              onTap: () {
                _showLogoutConfirmation(context);
              },
            ),
          ),
        ),
      ),
    ];
  }

  void _showLogoutConfirmation(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Logout',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF8a5bf7),
            ),
          ),
          content: Text(
            'Are you sure you want to logout? You will return to the Welcome page.',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8a5bf7),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B6B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                // Call API logout to clear token
                await ApiService.logout();

                // Pop all routes and return to WelcomePage
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', // This assumes the WelcomePage is the root
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: Text(
                'Logout',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Placeholder pages for navigation

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Barbie');
    _emailController = TextEditingController(text: 'barbie@example.com');
    _phoneController = TextEditingController(text: '+63 917 123 4567');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 24 : 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name Field
              Text(
                'Full Name',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
              SizedBox(height: isMobile ? 8 : 12),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF8a5bf7).withValues(alpha: 0.6),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE9D5FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF8a5bf7),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 12 : 14,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 24),

              // Email Field
              Text(
                'Email Address',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
              SizedBox(height: isMobile ? 8 : 12),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF8a5bf7).withValues(alpha: 0.6),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE9D5FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF8a5bf7),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 12 : 14,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 24),

              // Phone Number Field
              Text(
                'Phone Number',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
              SizedBox(height: isMobile ? 8 : 12),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF8a5bf7).withValues(alpha: 0.6),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE9D5FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF8a5bf7),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 12 : 14,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
              SizedBox(height: isMobile ? 32 : 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8a5bf7),
                    padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Profile updated successfully!',
                          style: GoogleFonts.poppins(),
                        ),
                        backgroundColor: const Color(0xFF81C784), // Light green
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder pages
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

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
          'My Orders',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: isMobile ? 64 : 80,
              color: const Color(0xFF8a5bf7).withValues(alpha: 0.3),
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Text(
              'No Orders Yet',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8a5bf7),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              'Start shopping to place your first order',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8a5bf7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

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
          'Wishlist',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline,
              size: isMobile ? 64 : 80,
              color: const Color(0xFF8a5bf7).withValues(alpha: 0.3),
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Text(
              'Wishlist is Empty',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8a5bf7),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              'Add your favorite books to your wishlist',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8a5bf7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
          'Payment Methods',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.payment,
              size: isMobile ? 64 : 80,
              color: const Color(0xFF8a5bf7).withValues(alpha: 0.3),
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Text(
              'No Payment Methods',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8a5bf7),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              'Add a payment method to get started',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8a5bf7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: isMobile ? 16 : 24,
        ),
        child: ListView(
          children: [
            _buildSettingItem(
              context,
              Icons.notifications_outlined,
              'Notifications',
              'Manage notification preferences',
              isMobile,
            ),
            _buildSettingItem(
              context,
              Icons.lock_outline,
              'Privacy',
              'Control your privacy settings',
              isMobile,
            ),
            _buildSettingItem(
              context,
              Icons.language,
              'Language',
              'Change app language',
              isMobile,
            ),
            _buildSettingItem(
              context,
              Icons.brightness_6,
              'Theme',
              'Choose light or dark theme',
              isMobile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool isMobile,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
      child: Container(
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
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color(0xFF8a5bf7),
            size: isMobile ? 24 : 28,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF8a5bf7),
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8a5bf7),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: isMobile ? 16 : 18,
            color: const Color(0xFF8a5bf7),
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Feature coming soon!',
                  style: GoogleFonts.poppins(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
          'Help Center',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8a5bf7),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: isMobile ? 16 : 24,
        ),
        child: ListView(
          children: [
            _buildHelpItem(
              'FAQ',
              'Frequently asked questions',
              Icons.help_outline,
              isMobile,
            ),
            _buildHelpItem(
              'Contact Support',
              'Get in touch with our support team',
              Icons.mail_outline,
              isMobile,
            ),
            _buildHelpItem(
              'Terms & Conditions',
              'Read our terms and conditions',
              Icons.description_outlined,
              isMobile,
            ),
            _buildHelpItem(
              'Privacy Policy',
              'View our privacy policy',
              Icons.privacy_tip_outlined,
              isMobile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(
    String title,
    String subtitle,
    IconData icon,
    bool isMobile,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
      child: Container(
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
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color(0xFF8a5bf7),
            size: isMobile ? 24 : 28,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF8a5bf7),
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8a5bf7),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: isMobile ? 16 : 18,
            color: const Color(0xFF8a5bf7),
          ),
        ),
      ),
    );
  }
}
