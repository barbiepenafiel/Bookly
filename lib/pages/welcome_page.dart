import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _contentAnimationController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _contentFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Content animation controller
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Fade animations
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn),
    );

    _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations sequentially
    _logoAnimationController.forward().then((_) {
      _contentAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _contentAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 20 : 40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo with fade animation
                  FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: Column(
                      children: [
                        Container(
                          width: isMobile ? 100 : 130,
                          height: isMobile ? 100 : 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8a5bf7),
                            borderRadius: BorderRadius.circular(
                              isMobile ? 25 : 35,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF8a5bf7,
                                ).withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '📚',
                              style: TextStyle(fontSize: isMobile ? 50 : 70),
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 15 : 20),
                        Text(
                          'Bookly',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 28 : 36,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF8a5bf7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: isMobile ? 40 : 60),

                  // Get Started Button
                  FadeTransition(
                    opacity: _contentFadeAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      height: isMobile ? 56 : 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8a5bf7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              isMobile ? 15 : 20,
                            ),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 20 : 25),

                  // Continue as Guest
                  FadeTransition(
                    opacity: _contentFadeAnimation,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: Text(
                        'Continue as Guest',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 15 : 17,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
