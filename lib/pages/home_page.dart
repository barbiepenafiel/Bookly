import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'category_page.dart';
import 'welcome_page.dart';
import 'book_detail_page.dart';
import '../widgets/cart_icon_with_badge.dart';

class HomePage extends StatefulWidget {
  final int initialTabIndex;

  const HomePage({super.key, this.initialTabIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late int _selectedTabIndex;
  late List<AnimationController> _bookCardAnimations;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Fiction', 'icon': Icons.menu_book},
    {'name': 'Romance', 'icon': Icons.menu_book},
    {'name': 'Sci-Fi', 'icon': Icons.menu_book},
    {'name': 'Mystery', 'icon': Icons.menu_book},
    {'name': 'Biography', 'icon': Icons.menu_book},
    {'name': 'History', 'icon': Icons.menu_book},
  ];

  final List<Map<String, dynamic>> featuredBooks = [
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'price': 12.99,
      'image': 'assets/images/The Great Gatsby.jpg',
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'price': 14.99,
      'image': 'assets/images/To Kill a Mockingbird.jpg',
    },
    {
      'title': 'Pride and Prejudice',
      'author': 'Jane Austen',
      'price': 11.99,
      'image': 'assets/images/Pride and Prejudice.jpg',
    },
    {
      'title': 'The Catcher in the Rye',
      'author': 'J.D. Salinger',
      'price': 13.99,
      'image': 'assets/images/The Catcher in the Rye.jpg',
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'price': 15.99,
      'image': 'assets/images/1984.jpg',
    },
    {
      'title': 'Jane Eyre',
      'author': 'Charlotte Brontë',
      'price': 12.99,
      'image': 'assets/images/Jane Eyre.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
    _bookCardAnimations = List.generate(
      6,
      (index) => AnimationController(
        duration: Duration(milliseconds: 500 + (index * 100)),
        vsync: this,
      ),
    );

    // Start animations
    for (var controller in _bookCardAnimations) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _bookCardAnimations) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF8a5bf7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const WelcomePage()),
            );
          },
        ),
        title: Text(
          'Bookly',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 22 : 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: _selectedTabIndex == 0
          ? _buildHomeTab(context, isMobile)
          : _selectedTabIndex == 1
          ? _buildCategoriesTab(context, isMobile)
          : _selectedTabIndex == 2
          ? const CartPage()
          : const ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF8a5bf7),
        unselectedItemColor: const Color(0xFFCCCCCC),
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedTabIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedTabIndex == 1
                  ? Icons.menu_book
                  : Icons.menu_book_outlined,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: CartIconWithBadge(isSelected: _selectedTabIndex == 2),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedTabIndex == 3 ? Icons.person : Icons.person_outline,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context, bool isMobile) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promotional Banner (uses assets/bannerbg.jpg)
          Container(
            margin: EdgeInsets.all(isMobile ? 16 : 24),
            height: isMobile ? 200 : 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/hero-bg1.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(
                    194,
                    133,
                    89,
                    236,
                  ).withValues(alpha: 0.18),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Subtle logo/icon in the center
                Center(
                  child: Icon(
                    Icons.auto_stories,
                    size: isMobile ? 80 : 120,
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                // Purple gradient overlay for brand tint
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: isMobile ? 120 : 160,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF8a5bf7).withValues(alpha: 0.6),
                          Color(0xFF7c4de6).withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: isMobile ? 16 : 24,
                  left: isMobile ? 16 : 24,
                  right: isMobile ? 16 : 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Summer Sale',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: isMobile ? 4 : 8),
                      Text(
                        'Up to 50% off on selected books',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Categories Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
            child: Text(
              'Categories',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8a5bf7),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          SizedBox(
            height: isMobile ? 100 : 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: isMobile ? 12 : 16),
                  child: _buildCategoryChip(
                    context,
                    categories[index],
                    isMobile,
                  ),
                );
              },
            ),
          ),

          SizedBox(height: isMobile ? 24 : 32),

          // Featured Books Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Books',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF8a5bf7),
                  ),
                ),
                Text(
                  'See all',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8a5bf7),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 2 : 3,
                crossAxisSpacing: isMobile ? 12 : 16,
                mainAxisSpacing: isMobile ? 12 : 16,
                childAspectRatio: 0.65,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _bookCardAnimations[index],
                          curve: Curves.easeOut,
                        ),
                      ),
                  child: FadeTransition(
                    opacity: _bookCardAnimations[index],
                    child: _buildBookCard(context, isMobile, index),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: isMobile ? 24 : 32),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab(BuildContext context, bool isMobile) {
    return GridView.builder(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 3,
        crossAxisSpacing: isMobile ? 12 : 16,
        mainAxisSpacing: isMobile ? 12 : 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryCard(context, categories[index], isMobile);
      },
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    Map<String, dynamic> category,
    bool isMobile,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryPage(
              categoryName: category['name'],
              categoryIcon: category['icon'],
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: isMobile ? 70 : 80,
            height: isMobile ? 70 : 80,
            decoration: BoxDecoration(
              color: const Color(0xFF8a5bf7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8a5bf7).withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                category['icon'],
                size: isMobile ? 32 : 40,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            category['name'],
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8a5bf7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    Map<String, dynamic> category,
    bool isMobile,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryPage(
              categoryName: category['name'],
              categoryIcon: category['icon'],
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [const Color(0xFF8a5bf7), const Color(0xFF7c4de6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category['icon'],
                size: isMobile ? 50 : 60,
                color: Colors.white,
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Text(
                category['name'],
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, bool isMobile, int index) {
    final book = featuredBooks[index];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookDetailPage(book: book, bookIndex: index),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        book['image'] ?? 'assets/images/The Great Gatsby.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: book['image'] == null
                      ? Center(
                          child: Icon(
                            Icons.auto_stories,
                            size: isMobile ? 40 : 50,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 12 : 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF8a5bf7),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            book['author'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 10 : 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF8a5bf7),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${book['price'].toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 12 : 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8a5bf7),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (starIndex) => Icon(
                                Icons.star,
                                size: isMobile ? 10 : 12,
                                color: starIndex < 4
                                    ? Colors.amber
                                    : Colors.grey[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
