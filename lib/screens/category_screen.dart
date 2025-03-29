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
      backgroundColor: Colors.white, // ✅ Set background color to white
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories.map((category) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 32, // ✅ Increased size from 25 to 35
                      child: Image.asset(category["image"]!,
                          width: 40), // ✅ Increased image size from 30 to 50
                    ),
                    SizedBox(height: 5),
                    Text(category["name"]!,
                        style: TextStyle(
                            fontSize: 14)), // Slightly larger font size
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
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
                      color: Colors.white, // ✅ White background
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10), // ✅ Added padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(products[index]["image"]!,
                            width: 120), // ✅ Increased size from 80 to 100
                        SizedBox(height: 10),
                        Text(
                          products[index]["name"]!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15), // ✅ Slightly larger font
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          products[index]["price"]!,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
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
