import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryScreen(),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Apple", "image": "assets/apple.png"},
    {"name": "Samsung", "image": "assets/samsung.png"},
    {"name": "Asus", "image": "assets/asus.png"},
    {"name": "Oppo", "image": "assets/oppo.png"},
  ];

  final List<Map<String, String>> products = [
    {
      "name": "iPhone 15 Pro",
      "price": "₹1,30,990",
      "image": "assets/iphone.jpg"
    },
    {"name": "Redmi Note 13", "price": "₹22,990", "image": "assets/redmi.png"},
    {
      "name": "iPhone 15 Pro",
      "price": "₹1,30,990",
      "image": "assets/iphone.jpg"
    },
    {"name": "Redmi Note 13", "price": "₹22,990", "image": "assets/redmi.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Category",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories.map((category) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 4)),
                        ],
                      ),
                      padding: EdgeInsets.all(14),
                      child: Image.asset(category["image"]!,
                          width: 50), // Adjusted size
                    ),
                    SizedBox(height: 6),
                    Text(category["name"]!,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Products Section
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(products[index]["image"]!,
                            width: 100), // Increased size
                        SizedBox(height: 10),
                        Text(
                          products[index]["name"]!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16), // Increased font size
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6),
                        Text(
                          products[index]["price"]!,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
