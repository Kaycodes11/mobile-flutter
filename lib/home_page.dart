import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  List<Widget> pages = const [ProductsList(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: const ProductsList(),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          onTap: (value) {
            // BottomNavigationBarItem are index based; so when tapped, value (i.e. index) is going be assigned to currentPage
            setState(() {
              currentPage = value;
            });
          },
          currentIndex: currentPage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          ]),
    );
  }
}

// context uses bottom up approach to find the value from the nearest ancestor and as soon as it found, it stops and use that : timestamp= 17:54:36 and if it doesn't found then it will use default/initial value
