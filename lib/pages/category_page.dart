import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final IconData categoryIcon;

  const CategoryPage({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedTabIndex = 0;

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
          widget.categoryName,
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
            vertical: isMobile ? 16 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured in ${widget.categoryName}',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8a5bf7),
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              GridView.builder(
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
                  return _buildBookCard(context, isMobile, index);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
          _handleNavigation(index);
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
            icon: Icon(
              _selectedTabIndex == 2
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
            ),
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

  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        // Navigate to Home (Home tab)
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: 0,
        );
        break;
      case 1:
        // Navigate to Home (Categories tab)
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: 1,
        );
        break;
      case 2:
        // Navigate to Home (Cart tab)
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: 2,
        );
        break;
      case 3:
        // Navigate to Home (Profile tab)
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: 3,
        );
        break;
    }
  }

  Widget _buildBookCard(BuildContext context, bool isMobile, int index) {
    // Category-specific books (6 per category)
    final categoryBooks = {
      'Fiction': [
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
      ],
      'Romance': [
        {
          'title': 'Pride and Prejudice',
          'author': 'Jane Austen',
          'price': 11.99,
          'image': 'assets/images/Pride and Prejudice.jpg',
        },
        {
          'title': 'Jane Eyre',
          'author': 'Charlotte Brontë',
          'price': 12.99,
          'image': 'assets/images/Jane Eyre.jpg',
        },
        {
          'title': 'Wuthering Heights',
          'author': 'Emily Brontë',
          'price': 13.99,
          'image':
              'assets/images/The Great Gatsby.jpg', // Using available image
        },
        {
          'title': 'The Notebook',
          'author': 'Nicholas Sparks',
          'price': 10.99,
          'image':
              'assets/images/To Kill a Mockingbird.jpg', // Using available image
        },
        {
          'title': 'Outlander',
          'author': 'Diana Gabaldon',
          'price': 16.99,
          'image':
              'assets/images/The Catcher in the Rye.jpg', // Using available image
        },
        {
          'title': 'The Time Traveler\'s Wife',
          'author': 'Audrey Niffenegger',
          'price': 14.99,
          'image': 'assets/images/1984.jpg', // Using available image
        },
      ],
      'Sci-Fi': [
        {
          'title': 'Dune',
          'author': 'Frank Herbert',
          'price': 17.99,
          'image':
              'assets/images/The Great Gatsby.jpg', // Using available image
        },
        {
          'title': '1984',
          'author': 'George Orwell',
          'price': 15.99,
          'image': 'assets/images/1984.jpg',
        },
        {
          'title': 'Foundation',
          'author': 'Isaac Asimov',
          'price': 14.99,
          'image':
              'assets/images/To Kill a Mockingbird.jpg', // Using available image
        },
        {
          'title': 'Neuromancer',
          'author': 'William Gibson',
          'price': 13.99,
          'image':
              'assets/images/Pride and Prejudice.jpg', // Using available image
        },
        {
          'title': 'The Left Hand of Darkness',
          'author': 'Ursula K. Le Guin',
          'price': 12.99,
          'image':
              'assets/images/The Catcher in the Rye.jpg', // Using available image
        },
        {
          'title': 'Ender\'s Game',
          'author': 'Orson Scott Card',
          'price': 13.99,
          'image': 'assets/images/Jane Eyre.jpg', // Using available image
        },
      ],
      'Mystery': [
        {
          'title': 'The Great Gatsby',
          'author': 'F. Scott Fitzgerald',
          'price': 12.99,
          'image': 'assets/images/The Great Gatsby.jpg',
        },
        {
          'title': 'Murder on the Orient Express',
          'author': 'Agatha Christie',
          'price': 11.99,
          'image':
              'assets/images/To Kill a Mockingbird.jpg', // Using available image
        },
        {
          'title': 'The Girl with the Dragon Tattoo',
          'author': 'Stieg Larsson',
          'price': 15.99,
          'image':
              'assets/images/Pride and Prejudice.jpg', // Using available image
        },
        {
          'title': 'And Then There Were None',
          'author': 'Agatha Christie',
          'price': 12.99,
          'image':
              'assets/images/The Catcher in the Rye.jpg', // Using available image
        },
        {
          'title': 'The Maltese Falcon',
          'author': 'Dashiell Hammett',
          'price': 10.99,
          'image': 'assets/images/1984.jpg', // Using available image
        },
        {
          'title': 'Rebecca',
          'author': 'Daphne du Maurier',
          'price': 13.99,
          'image': 'assets/images/Jane Eyre.jpg', // Using available image
        },
      ],
      'Biography': [
        {
          'title': 'Steve Jobs',
          'author': 'Walter Isaacson',
          'price': 18.99,
          'image':
              'assets/images/The Great Gatsby.jpg', // Using available image
        },
        {
          'title': 'The Diary of Anne Frank',
          'author': 'Anne Frank',
          'price': 12.99,
          'image':
              'assets/images/To Kill a Mockingbird.jpg', // Using available image
        },
        {
          'title': 'Becoming',
          'author': 'Michelle Obama',
          'price': 19.99,
          'image':
              'assets/images/Pride and Prejudice.jpg', // Using available image
        },
        {
          'title': 'I Am Malala',
          'author': 'Malala Yousafzai',
          'price': 16.99,
          'image':
              'assets/images/The Catcher in the Rye.jpg', // Using available image
        },
        {
          'title': 'The Story of My Life',
          'author': 'Helen Keller',
          'price': 9.99,
          'image': 'assets/images/1984.jpg', // Using available image
        },
        {
          'title': 'Born to Run',
          'author': 'Christopher McDougall',
          'price': 14.99,
          'image': 'assets/images/Jane Eyre.jpg', // Using available image
        },
      ],
      'History': [
        {
          'title': 'The Guns of August',
          'author': 'Barbara W. Tuchman',
          'price': 16.99,
          'image':
              'assets/images/The Great Gatsby.jpg', // Using available image
        },
        {
          'title': 'A Brief History of Time',
          'author': 'Stephen Hawking',
          'price': 15.99,
          'image':
              'assets/images/To Kill a Mockingbird.jpg', // Using available image
        },
        {
          'title': 'Sapiens',
          'author': 'Yuval Noah Harari',
          'price': 18.99,
          'image':
              'assets/images/Pride and Prejudice.jpg', // Using available image
        },
        {
          'title': 'The Rise and Fall of the Third Reich',
          'author': 'William Shirer',
          'price': 19.99,
          'image':
              'assets/images/The Catcher in the Rye.jpg', // Using available image
        },
        {
          'title': '1491',
          'author': 'Charles C. Mann',
          'price': 17.99,
          'image': 'assets/images/1984.jpg', // Using available image
        },
        {
          'title': 'The Code Breaker',
          'author': 'Walter Isaacson',
          'price': 18.99,
          'image': 'assets/images/Jane Eyre.jpg', // Using available image
        },
      ],
    };

    final books =
        categoryBooks[widget.categoryName] ?? categoryBooks['Fiction'] ?? [];

    if (index >= books.length) {
      return const SizedBox.shrink();
    }

    final book = books[index];
    final bookTitle = book['title'] as String;
    final bookAuthor = book['author'] as String;
    final bookPrice = book['price'] as double;
    final bookImage = book['image'] as String?;

    return Card(
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
                      bookImage ?? 'assets/images/The Great Gatsby.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: bookImage == null
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
                    Text(
                      bookTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8a5bf7),
                      ),
                    ),
                    Text(
                      bookAuthor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 10 : 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8a5bf7),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${bookPrice.toStringAsFixed(2)}',
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
    );
  }
}
