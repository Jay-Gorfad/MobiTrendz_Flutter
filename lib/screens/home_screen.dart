import 'package:flutter/material.dart';
import 'package:mobitrendz/screens/product_details.dart';
import 'package:mobitrendz/screens/category_screen.dart';
import 'package:mobitrendz/screens/cart_screen.dart'; // Import Cart Screen
import 'package:mobitrendz/screens/orders_screen.dart'; // Import Orders Screen
import 'package:mobitrendz/screens/profile_screen.dart'; // Import Profile Screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track selected tab

  // List of Screens
  final List<Widget> _screens = [
    HomePageContent(),
    CartScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex], // Show selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // Set background color to white ✅
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// Separate Widget for Home Page Content
class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage("assets/profiles.png"),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Jay Gorfad",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Search Bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Special Offers Section
            const Text("Special Offers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade400, blurRadius: 4)
                ],
              ),
              child: const Center(
                child: Text(
                  "10% Discount",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Brand Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBrandIcon("assets/apple.png", "Apple", context),
                _buildBrandIcon("assets/samsung.png", "Samsung", context),
                _buildBrandIcon("assets/asus.png", "Asus", context),
                _buildBrandIcon("assets/oppo.png", "Oppo", context),
              ],
            ),
            const SizedBox(height: 25),
            // Most Popular Section
            const Text("Most Popular",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.75,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildProductCard(
                    "assets/iphone.jpg", "iPhone 15 Pro", "₹1,30,990", context),
                _buildProductCard(
                    "assets/redmi.png", "Redmi Note 13", "₹22,990", context),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget for brand icons
  Widget _buildBrandIcon(
      String imagePath, String brandName, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryScreen()),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 35,
            child: Image.asset(imagePath, width: 40),
          ),
          const SizedBox(height: 5),
          Text(brandName,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Widget for product card
  Widget _buildProductCard(
      String imagePath, String name, String price, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              imagePath: imagePath,
              name: name,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white, // Background color added ✅
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(imagePath, width: 90, height: 90),
            ),
            const SizedBox(height: 10),
            Text(name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2), // Adjusted spacing ✅
            Text(price,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
